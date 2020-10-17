//
//  EventComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 11/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct EventComponent: IdentifiableComponent {
    var id: String
    var event: Event
    
    func renderContent() -> EventComponentView {
        return EventComponentView()
    }
    
    func render(in content: EventComponentView) {
        content.titleLabel.text = event.title
        
        if event.allDayEvent {
            content.timeLabel.text = "all-day"
        } else {
            content.timeLabel.text = event.timeParsed
        }
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: EventComponent) -> Bool {
        return event.title != next.event.title
    }
}
