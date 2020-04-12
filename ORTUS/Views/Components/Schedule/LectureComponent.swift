//
//  LectureComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 12/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

struct LectureComponent: IdentifiableComponent {
    var id: String
    var lecture: Lecture
    
    func renderContent() -> LectureComponentView {
        return LectureComponentView()
    }
    
    func render(in content: LectureComponentView) {
        content.startTimeLabel.text = lecture.timeFromParsed
        content.endTimeLabel.text = lecture.timeTillParsed
        content.nameLabel.text = lecture.name
        content.addressLabel.text = lecture.address
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: LectureComponent) -> Bool {
        return lecture.id != next.lecture.id
    }
}
