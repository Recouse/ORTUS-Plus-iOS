//
//  CourseComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 02/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct CourseComponent: IdentifiableComponent {
    var id: String
    var course: Course
    
    let colors: [UIColor] = [
        .systemBlue, .systemGreen, .systemOrange, .systemPink,
        .systemPurple, .systemRed, .systemTeal, .systemYellow
    ]
    
    func renderContent() -> CourseComponentView {
        return CourseComponentView()
    }
    
    func render(in content: CourseComponentView) {
//        if let color = colors.randomElement() {
        content.imageContainerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        content.imageView.tintColor = .systemBlue
//        }
        content.imageView.image = UIImage(named: "course")
        content.titleLabel.text = course.name
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
    
    func shouldContentUpdate(with next: CourseComponent) -> Bool {
        return course.id != next.course.id
    }
}
