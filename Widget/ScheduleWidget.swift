//
//  ScheduleWidget.swift
//  Widget
//
//  Created by Firdavs Khaydarov on 10/25/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import WidgetKit
import SwiftUI

@main
struct ScheduleWidget: Widget {
    let kind: String = "ScheduleWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ScheduleProvider()) { entry in
            ScheduleWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Schedule Widget")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleWidgetEntryView(entry: ScheduleEntry(date: Date(), items: []))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
