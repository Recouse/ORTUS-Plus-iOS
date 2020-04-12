//
//  LectureComponent.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 09/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

struct LectureComponent: IdentifiableComponent {
    var id: String
    var lecture: Lecture
    var date: Date?
    
    func renderContent() -> LectureComponentView {
        return LectureComponentView()
    }
    
    func render(in content: LectureComponentView) {
        content.nameLabel.text = lecture.name
        
        var time = "\(lecture.timeFromParsed)-\(lecture.timeTillParsed)"
        
        if let date = date {
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "Europe/Riga")
            dateFormatter.dateFormat = "EEEE, d MMMM"
            
            time += ", "
            time += dateFormatter.string(from: date)
        }
        
        content.addressLabel.text = time
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
//        return CGSize(width: bounds.width, height: 70)
        return nil
    }
    
    func shouldContentUpdate(with next: LectureComponent) -> Bool {
        return lecture.id != next.lecture.id
    }
}
