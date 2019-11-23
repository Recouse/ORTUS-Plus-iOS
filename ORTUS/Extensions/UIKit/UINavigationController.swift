//
//  UINavigationController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 22/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

extension UINavigationController {
    func showBorderLine() {
//        getBorderLine()?.isHidden = false
        navigationBar.setValue(false, forKey: "hidesShadow")
    }

    func hideBorderLine() {
//        getBorderLine()?.isHidden = true
        navigationBar.setValue(true, forKey: "hidesShadow")
    }

    private func getBorderLine() -> UIImageView? {
        return navigationBar.subviews
            .flatMap { $0.subviews }
            .compactMap { $0 as? UIImageView }
            .filter { $0.bounds.size.width == navigationBar.bounds.size.width }
            .filter { $0.bounds.size.height <= 2 }
            .first
    }
}
