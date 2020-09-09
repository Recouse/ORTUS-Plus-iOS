//
//  TodayViewController.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 07/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import NotificationCenter
import Storage
import Models
import Carbon

class TodayViewController: UIViewController {
    typealias Schedule = [(key: String, value: [ScheduleItem])]
    
    static let appGroup = "group.me.recouse.ORTUS"
    
    weak var todayView: TodayView! { return view as? TodayView }
    weak var tableView: UITableView! { return todayView.tableView }
    
    lazy var renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Europe/Riga")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
    var schedule: Schedule = []
    
    override func loadView() {
        view = TodayView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareData()
    }
    
    func render() {
        var data: [CellNode] = []
        
        outerLoop: for day in 0...6 {
            let date = Calendar.current.date(byAdding: .day, value: day, to: Date())!
            let dateString = dateFormatter.string(from: date)

            for items in schedule {
                if items.key == dateString {
                    for item in items.value {
                        if let event = item.item(as: Event.self) {
                            // Get year, month and day from string
                            let itemsDate = items.key.components(separatedBy: "-")
                                .compactMap { Int($0) }
                            // Date from time of event or date from string
                            var eventDate = event.date ?? item.timeDate ?? dateFormatter.date(from: items.key)
                            // Add year, month and day to only time date

                            if eventDate != nil, itemsDate.count == 3 {
                                eventDate = Calendar.current.date(bySetting: .year, value: itemsDate[0], of: eventDate!)
                                eventDate = Calendar.current.date(bySetting: .month, value: itemsDate[1], of: eventDate!)
                                eventDate = Calendar.current.date(bySetting: .day, value: itemsDate[2], of: eventDate!)

                                if eventDate! < Date() {
                                    continue
                                }
                            }

                            data.append(CellNode(EventComponent(id: event.title, event: event, date: eventDate)))
                        }

                        if let lecture = item.item(as: Lecture.self) {
                            let time = lecture.timeTillParsed.components(separatedBy: ":")
                                .compactMap { Int($0) }
                            let date = dateFormatter.date(from: lecture.date)

                            if var lectureDate = date, time.count == 2 {
                                lectureDate = Calendar.current.date(bySetting: .hour, value: time[0], of: lectureDate)!
                                lectureDate = Calendar.current.date(bySetting: .minute, value: time[1], of: lectureDate)!

                                if lectureDate < Date() {
                                    continue
                                }
                            }

                            data.append(CellNode(LectureComponent(id: lecture.id, lecture: lecture, date: date)))
                        }
                    }

                    if !data.isEmpty {
                        break outerLoop
                    }
                }
            }
        }
        
        extensionContext?.widgetLargestAvailableDisplayMode = data.count > 2 ? .expanded : .compact
        
        if data.isEmpty {
            data.append(
                CellNode(
                    EmptyComponent(
                        id: "empty",
                        onSelect: { [unowned self] in
                            self.openApp()
                        }
                    )
                )
            )
        }
        
        renderer.render {
            Group(
                of: extensionContext?.widgetActiveDisplayMode == .compact ? Array(data.prefix(2)) : data
            ) { cell in
                cell
            }
        }
    }
    
    func openApp() {
        extensionContext?.open(URL(string: "ortus://open?module=schedule")!, completionHandler: nil)
    }
    
    private func sortSchedule(from response: ScheduleResponse) -> Schedule {
        let sortedResponse = response.result.sorted(by: {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_LV")
            dateFormatter.timeZone = TimeZone(identifier: "Europe/Riga")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            guard let date0 = dateFormatter.date(from: $0.key),
                let date1 = dateFormatter.date(from: $1.key) else {
                return false
            }
            
            return date0 < date1
        })
        
        var schedule: [(key: String, value: [ScheduleItem])] = []
        for pair in sortedResponse {
            var items: [ScheduleItem] = []
            
            if UserDefaults(suiteName: "group.me.recouse.ORTUS")?.bool(forKey: "show_events") == true {
                pair.value.events.forEach { items.append(ScheduleItem($0, time: $0.timeParsed)) }
            }
            pair.value.lectures.forEach { items.append(ScheduleItem($0, time: $0.timeFromParsed)) }
            
            items.sort(by: {
                guard let firstDate = $0.timeDate, let secondDate = $1.timeDate else {
                    return false
                }
                
                return firstDate < secondDate
            })
            
            if !items.isEmpty {
                schedule.append((key: pair.key, value: items))
            }
        }
        
        return schedule
    }
}

extension TodayViewController: NCWidgetProviding {
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        let path = FileManager.sharedContainerURL()
        let disk = DiskStorage(path: path)
        let storage = CodableStorage(storage: disk)
        
        do {
            let response: ScheduleResponse = try storage.fetch(for: "scheduleCache")
            schedule = sortSchedule(from: response)
            
            completionHandler(NCUpdateResult.newData)
        } catch {
            schedule = []
            
            completionHandler(NCUpdateResult.failed)
        }
        
        render()
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        render()
        
        preferredContentSize = CGSize(
            width: maxSize.width,
            height: min(tableView.contentSize.height + 10, maxSize.height)
        )
    }
}

extension TodayViewController {
    func prepareData() {
        renderer.target = tableView
        
        renderer.adapter.didSelect = { [unowned self] _ in
            self.openApp()
        }
    }
}

