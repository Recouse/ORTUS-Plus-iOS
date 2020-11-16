//
//  ScheduleEntry.swift
//  WidgetExtension
//
//  Created by Firdavs Khaydarov on 10/26/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import WidgetKit

struct ScheduleEntry: TimelineEntry {
    let date: Date
    let itemsDate: Date
    let items: [ScheduleItem]
}
