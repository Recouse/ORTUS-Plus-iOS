//
//  GradeComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

struct GradeComponent: IdentifiableComponent {
    var id: Int
    var mark: Mark
    
    func renderContent() -> GradeComponentView {
        return GradeComponentView()
    }
    
    func render(in content: GradeComponentView) {
        content.courseLabel.text = mark.courseFullName
        content.creditPointsLabel.text = "\(mark.creditPoints) CP"
        content.lecturerLabel.text = mark.lecturerFullName
        content.gradeLabel.text = mark.mark
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: GradeComponent) -> Bool {
        return id != next.id
    }
}
