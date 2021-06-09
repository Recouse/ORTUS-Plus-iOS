//
//  GradeComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct GradeComponent: Component {
    var mark: Mark
    
    func renderContent() -> GradeComponentView {
        return GradeComponentView()
    }
    
    func render(in content: GradeComponentView) {
        content.courseLabel.text = mark.courseFullName
        content.lecturerLabel.text = mark.lecturerFullName
        
        let grade: String
        
        if let mark = mark.mark {
            if self.mark.markType == "Ieskaite" {
                grade = mark == "11" ? "P" : "-"
            } else {
                grade = mark
            }
        } else {
            grade = self.mark.markType == "Ieskaite" ? "-" : "0"
        }
        
        content.gradeLabel.text = grade
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 67)
    }
}
