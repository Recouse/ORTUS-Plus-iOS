//
//  Overlay.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/3/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class Overlay {
    static let viewTag = 123456
    
    static func showLoading(on viewController: UIViewController, animated: Bool = true) {
        viewController.navigationController?.view.isUserInteractionEnabled = false
        
        let overlayView = UIView()
        overlayView.tag = Self.viewTag
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        overlayView.alpha = 0
        
        viewController.view.addSubview(overlayView)
        overlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        overlayView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        activityIndicator.startAnimating()
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                overlayView.alpha = 1
            }
        } else {
            overlayView.alpha = 1
        }
    }
    
    static func removeLoading(from viewController: UIViewController, animated: Bool = true) {
        viewController.navigationController?.view.isUserInteractionEnabled = true
        
        guard let overlayView = viewController.view.subviews.first(where: { $0.tag == Self.viewTag }) else {
            return
        }
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                overlayView.alpha = 0
            }) { _ in
                overlayView.removeFromSuperview()
            }
        } else {
            overlayView.removeFromSuperview()
        }
    }
}
