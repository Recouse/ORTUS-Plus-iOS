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

    var body: some View {        
        ForEach(entry.items.prefix(2)) { item in
            Group {
                if let event = item.item(as: Event.self) {
                    EventItemView(event: event)
                }
                
                if let lecture = item.item(as: Lecture.self) {
                    LectureItemView(lecture: lecture)
                }
            }
        }
    }
}
