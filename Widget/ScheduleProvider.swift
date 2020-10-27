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
        ScheduleEntry(date: Date(), items: placeholderItems)
    }

    func getSnapshot(in context: Context, completion: @escaping (ScheduleEntry) -> ()) {
        let entry = ScheduleEntry(date: Date(), items: placeholderItems)
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
        
        var entryItems: [ScheduleItem] = []
                
        if let sorted = response?.sorted() {
            outerLoop: for day in 0...6 {
                let date = Calendar.current.date(byAdding: .day, value: day, to: Date())!
                let dateString = dateFormatter.string(from: date)

                for items in sorted {
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

                                entryItems.append(item)
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

                                entryItems.append(item)
                            }
                        }

                        if !entryItems.isEmpty {
                            break outerLoop
                        }
                    }
                }
            }
            
            let nextDate = Calendar.current.date(
                byAdding: .day,
                value: 1,
                to: currentDate
            )!
            let entryDate = Calendar.current.date(
                bySettingHour: 0,
                minute: 0,
                second: 0,
                of: nextDate
            )!
            let entry = ScheduleEntry(date: entryDate, items: entryItems)
            entries.append(entry)
        } else {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: 1,
                to: currentDate
            )!
            let entry = ScheduleEntry(date: entryDate, items: [])
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
