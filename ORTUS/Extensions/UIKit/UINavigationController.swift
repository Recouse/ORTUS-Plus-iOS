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
        navigationBar.setValue(false, forKey: "hidesShadow")
    }

    func hideBorderLine() {
        navigationBar.setValue(true, forKey: "hidesShadow")
    }
}
