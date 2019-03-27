//
//  UIApplication.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 22/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

extension UIApplication {
    var statusBarView : UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}


