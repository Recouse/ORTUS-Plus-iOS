//
//  VersionComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct VersionComponent: IdentifiableComponent {
    var version: String
    var onSelect: (() -> Void)?
    
    var id: String {
        return version
    }
    
    func renderContent() -> VersionComponentView {
        return VersionComponentView()
    }
    
    func render(in content: VersionComponentView) {
        content.onSelect = onSelect
        
        content.textLabel.text = "Version \(version)"
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
    
    func shouldContentUpdate(with next: VersionComponent) -> Bool {
        return version != next.version
    }
}
