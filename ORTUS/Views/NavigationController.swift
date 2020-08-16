//
//  NavigationController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

extension UINavigationController {
    var progressView: UIProgressView? {
        (self as? NavigationController)?._progressView
    }
}

class NavigationController: UINavigationController {
    var _progressView: UIProgressView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactivePopGestureRecognizer?.delegate = self
        
        view.backgroundColor = ColorCompatibility.systemBackground
        
        prepareNavigationBar()
        prepareToolbar()
        prepareProgressView()
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
    
    func prepareProgressView() {
        _progressView = UIProgressView(progressViewStyle: .bar)
        _progressView.tintColor = Asset.Colors.tintColor.color
        _progressView.isHidden = true
        
        view.addSubview(_progressView)
        _progressView.snp.makeConstraints {
            $0.bottom.equalTo(navigationBar.snp.bottom)
            $0.left.right.equalToSuperview()
        }
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
