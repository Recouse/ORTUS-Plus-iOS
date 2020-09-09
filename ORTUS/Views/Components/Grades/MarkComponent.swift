//
//  MarkComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

struct MarkComponent: Component {
    var mark: Mark
    
    func renderContent() -> MarkComponentView {
        return MarkComponentView()
    }
    
    func render(in content: MarkComponentView) {
        content.courseLabel.text = mark.courseFullName
        content.gradeLabel.text = mark.mark ?? "0"
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
}
