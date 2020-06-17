//
//  IconTextComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct IconTextComponent: Component {
    var title: String
    let icon: UIImage?
    let color: UIColor
    
    func renderContent() -> IconTextComponentView {
        return IconTextComponentView()
    }
    
    func render(in content: IconTextComponentView) {        
        content.imageContainerView.backgroundColor = color
        content.imageView.image = icon
        content.titleLabel.text = title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
}
