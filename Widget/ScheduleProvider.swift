//
//  ScheduleProvider.swift
//  WidgetExtension
//
//  Created by Firdavs Khaydarov on 10/26/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import WidgetKit

struct ScheduleProvider: TimelineProvider {
    let placeholderItems: [ScheduleItem] = [
        ScheduleItem(
            id: "1",
            item: Lecture(
                id: "math",
                date: "2025-10-27",
                timeFrom: "10:15",
                timeTill: "11:50",
                name: "Mathematics",
                type: "", lecturers: [], address: ""
            ),
            time: "10:15"
        ),
        ScheduleItem(
            id: "2",
            item: Lecture(
                id: "physics",
                date: "2025-10-27",
                timeFrom: "12:30",
                timeTill: "14:05",
                name: "Physics",
                type: "", lecturers: [], address: ""
            ),
            time: "14:05"
        )
    ]
    
    func placeholder(in context: Context) -> ScheduleEntry {
        ScheduleEntry(date: Date(), itemsDate: Date(), items: placeholderItems)
    }

    func getSnapshot(in context: Context, completion: @escaping (ScheduleEntry) -> ()) {
        let entry = ScheduleEntry(date: Date(), itemsDate: Date(), items: placeholderItems)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<ScheduleEntry>) -> ()) {
        var entries: [ScheduleEntry] = []
        let currentDate = Date()
        
        let dateFormatter = LatviaDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let cache = Cache(path: AppGroup.default.containerURL)
        let response = try? cache.fetch(
            ScheduleResponse.self,
            forKey: .schedule
        )
                
        guard let sorted = response?.sorted() else {
            let timeline = Timeline(
                entries: [
                    ScheduleEntry(date: currentDate, itemsDate: currentDate, items: [])
                ],
                policy: .atEnd
            )
            completion(timeline)
            return
        }
        
        for items in sorted {
            guard let itemsDate = dateFormatter.date(from: items.key) else {
                continue
            }
            
            guard currentDate <= itemsDate else {
                continue
            }
            
            var scheduleItems: [ScheduleItem] = []
            
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

                    scheduleItems.append(item)
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

                    scheduleItems.append(item)
                }
            }
            
            let nextDate = Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: itemsDate
            )!
            let entryDate = Calendar.current.startOfDay(for: nextDate)
            let entry = ScheduleEntry(date: entryDate, itemsDate: itemsDate, items: scheduleItems)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
