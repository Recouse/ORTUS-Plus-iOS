//
//  EmptyComponent.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 11/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct EmptyComponent: IdentifiableComponent {
    var id: String
    var onSelect: (() -> Void)?
    
    func renderContent() -> EmptyComponentView {
        return EmptyComponentView()
    }
    
    func render(in content: EmptyComponentView) {
        content.onSelect = onSelect
        content.textLabel.text = "No upcoming lessons 🎉"
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return bounds.size
    }
    
    func shouldContentUpdate(with next: EmptyComponent) -> Bool {
        return id != next.id
    }
}
