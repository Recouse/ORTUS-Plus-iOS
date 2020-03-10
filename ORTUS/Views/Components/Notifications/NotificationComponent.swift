//
//  NotificationComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

struct NotificationComponent: IdentifiableComponent {
    var id: String
    var notification: NotificationModel
    var onSelect: (() -> Void)?
    
    func renderContent() -> NotificationComponentView {
        return NotificationComponentView()
    }
    
    func render(in content: NotificationComponentView) {
        content.onSelect = onSelect
        
        content.titleLabel.text = notification.title
        content.dateLabel.text = Date(
            timeIntervalSince1970: TimeInterval(notification.date) / 1000
        ).formatted("MMM d, yyyy")
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: NotificationComponent) -> Bool {
        return notification.id != next.notification.id
    }
}
