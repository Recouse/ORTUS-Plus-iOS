//
//  UIApplication.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 22/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

extension UIApplication {
    
    // Source https://stackoverflow.com/a/57394751/7844080
    var statusBarView : UIView? {
        let tag = 38482458385 // Random tag
        
        if let statusBar = self.keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
            statusBarView.tag = tag

            self.keyWindow?.addSubview(statusBarView)
            
            return statusBarView
        }
        
        return nil
    }
}


