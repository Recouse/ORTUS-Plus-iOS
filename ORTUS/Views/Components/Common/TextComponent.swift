//
//  TextComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct TextComponent: Component {
    var text: String
    var onSelect: (() -> Void)?
    
    func renderContent() -> TextComponentView {
        return TextComponentView()
    }
    
    func render(in content: TextComponentView) {        
        content.textLabel.text = text
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
}
