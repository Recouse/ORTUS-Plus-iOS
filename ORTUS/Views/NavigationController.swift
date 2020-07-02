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
        
        interactivePopGestureRecognizer?.delegate = self
        
        view.backgroundColor = ColorCompatibility.systemBackground
        
        prepareNavigationBar()
        prepareToolbar()
    }
    
    func prepareNavigationBar() {
        navigationBar.prefersLargeTitles = true
        navigationBar.isTranslucent = true
        navigationBar.tintColor = Asset.Colors.tintColor.color
//        navigationBar.setBackgroundImage(UIColor.white.uiImage, for: .default)
//        navigationBar.shadowImage = UIImage()
    }
    
    func prepareToolbar() {
        toolbar.tintColor = Asset.Colors.tintColor.color
    }
    
    
}

extension NavigationController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        .top
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
