//
//  EventComponent.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 09/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

struct EventComponent: IdentifiableComponent {
    var id: String
    var event: Event
    var date: Date?
    
    func renderContent() -> EventComponentView {
        return EventComponentView()
    }
    
    func render(in content: EventComponentView) {
        content.titleLabel.text = event.title
        
        var time = ""
        
        if event.allDayEvent {
            time += "all-day"
        } else {
            time += event.timeParsed
        }
        
        if let date = date {
            time += ", "
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_LV")
            dateFormatter.timeZone = TimeZone(identifier: "Europe/Riga")
            dateFormatter.dateFormat = "EEEE, d MMMM"
            
            time += dateFormatter.string(from: date)
        }
        
        content.timeLabel.text = time
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: EventComponent) -> Bool {
        return event.title != next.event.title
    }
}

