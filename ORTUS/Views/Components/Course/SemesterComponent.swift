//
//  SemesterComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/20/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct SemesterComponent: Component {
    var semester: Semester
    
    func renderContent() -> SemesterComponentView {
        return SemesterComponentView()
    }
    
    func render(in content: SemesterComponentView) {
        content.coursesCountLabel.text = "\(semester.courses.count) courses"
        content.textLabel.text = semester.name ?? "Other"
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 60)
    }
}
