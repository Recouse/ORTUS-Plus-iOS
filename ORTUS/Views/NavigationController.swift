//
//  NavigationController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationBar()
    }
    
    func prepareNavigationBar() {
        navigationBar.prefersLargeTitles = true
        navigationBar.isTranslucent = true
        navigationBar.setBackgroundImage(UIColor.white.uiImage, for: .default)
//        navigationBar.shadowImage = UIImage()
    }
}
