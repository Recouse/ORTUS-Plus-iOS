//
//  TextDescriptionComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct TextDescriptionComponent: Component {
    var text: String
    var description: String?
    
    func renderContent() -> TextDescriptionComponentView {
        return TextDescriptionComponentView()
    }
    
    func render(in content: TextDescriptionComponentView) {
        content.textLabel.text = text
        content.descriptionLabel.text = description
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
}
