//
//  CourseComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 02/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct CourseComponent: Component {
    var course: Course
    
    func renderContent() -> CourseComponentView {
        return CourseComponentView()
    }
    
    func render(in content: CourseComponentView) {
        content.imageContainerView.backgroundColor = Asset.Colors.tintColor.color.withAlphaComponent(0.2)
        content.imageView.tintColor = Asset.Colors.tintColor.color
        
        content.imageView.image = Asset.Images.course.image
        content.titleLabel.text = course.name
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
}
