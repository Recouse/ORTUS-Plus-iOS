//
//  LectureComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 12/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct LectureComponent: IdentifiableComponent {
    var id: String
    var lecture: Lecture
    
    let colors: [UIColor] = [
        .systemBlue, .systemGreen, .systemOrange, .systemPink,
        .systemPurple, .systemRed, .systemTeal, .systemYellow
    ]
    
    func renderContent() -> LectureComponentView {
        return LectureComponentView()
    }
    
    func render(in content: LectureComponentView) {
//        if let color = colors.randomElement() {
//        content.imageContainerView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
//        content.imageView.tintColor = .systemBlue
//        }
        
        content.startTimeLabel.text = lecture.timeFrom
        content.endTimeLabel.text = lecture.timeTill
        content.nameLabel.text = lecture.name
        content.addressLabel.text = lecture.address
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
//        return CGSize(width: bounds.width, height: 70)
        return nil
    }
    
    func shouldContentUpdate(with next: LectureComponent) -> Bool {
        return lecture.id != next.lecture.id
    }
}
