//
//  TabBarItem.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class TabBarItem: UITabBarItem {
    override init() {
        super.init()
        
//        imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

