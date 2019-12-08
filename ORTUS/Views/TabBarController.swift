//
//  TabBarController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTabBar()
    }
}


extension TabBarController {
    func prepareTabBar() {
        tabBar.tintColor = Asset.Colors.tintColor.color
    }
}
