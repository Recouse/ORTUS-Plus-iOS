//
//  ScheduleWidgetEntryView.swift
//  WidgetExtension
//
//  Created by Firdavs Khaydarov on 10/26/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import SwiftUI

struct ScheduleWidgetEntryView : View {
    var entry: ScheduleProvider.Entry
    
    let weekdayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
    
    let dayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter
    }()

    let currentDate = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            VStack {
                Text(currentDate, formatter: weekdayDateFormatter)
                    .fontWeight(.medium)
                    .textCase(.uppercase)
                    .foregroundColor(.red)
                    .font(.caption2)
                    .padding([.leading, .top, .trailing])
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                
                Text(currentDate, formatter: dayDateFormatter)
                    .font(.title)
                    .padding([.leading, .trailing])
                    .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
            }
            
            LazyVGrid(columns: [GridItem()], content: {
                ForEach(entry.items.prefix(2)) { item in
                    if let event = item.item(as: Event.self) {
                        EventItemView(event: event)
                    }
                    
                    if let lecture = item.item(as: Lecture.self) {
                        LectureItemView(lecture: lecture)
                    }
                }
            })

            Spacer()
        })
        .widgetURL(URL(string: "ortus://open?module=schedule"))
    }
}
