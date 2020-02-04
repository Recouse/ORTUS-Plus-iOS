//
//  IconTextComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct IconTextComponent: IdentifiableComponent {
    var id: String
    var title: String
    let icon: UIImage?
    let color: UIColor
    var onSelect: (() -> Void)?
    
    func renderContent() -> IconTextComponentView {
        return IconTextComponentView()
    }
    
    func render(in content: IconTextComponentView) {
        content.onSelect = onSelect
        
        content.imageContainerView.backgroundColor = color
        content.imageView.image = icon
        content.titleLabel.text = title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
    
    func shouldContentUpdate(with next: IconTextComponent) -> Bool {
        return id != next.id
    }
}
