//
//  ContactComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

struct ContactComponent: IdentifiableComponent {
    var id: String
    var contact: Contact
    
    func renderContent() -> ContactComponentView {
        return ContactComponentView()
    }
    
    func render(in content: ContactComponentView) {
        if let previewPhoto = contact.previewPhoto {
            content.photoView.kf.setImage(with: URL(string: previewPhoto))
        }
        
        content.nameLabel.text = contact.name
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
    
    func shouldContentUpdate(with next: ContactComponent) -> Bool {
        return contact.id != next.contact.id
    }
}
