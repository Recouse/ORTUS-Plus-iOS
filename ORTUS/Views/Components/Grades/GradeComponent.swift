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
        content.gradeLabel.text = mark.mark ?? "0"
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 67)
    }
}
