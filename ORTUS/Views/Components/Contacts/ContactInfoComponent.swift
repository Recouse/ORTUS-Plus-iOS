//
//  ContactInfoComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/13/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

enum ContactInfoType {
    case text, email, phone, address
}

struct ContactInfoComponent: IdentifiableComponent {
    var id: String
    var type: ContactInfoType = .text
    var description: String
    
    func renderContent() -> ContactInfoComponentView {
        return ContactInfoComponentView()
    }
    
    func render(in content: ContactInfoComponentView) {
        content.titleLabel.text = id
        content.descriptionLabel.text = description
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: ContactInfoComponent) -> Bool {
        return id != next.id
    }
}
