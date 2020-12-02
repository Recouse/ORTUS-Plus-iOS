//
//  UIApplication.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 22/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

extension UIApplication {
    var activeScene: UIWindowScene? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .first
    }
    
    var keyWindow: UIWindow? {
        activeScene?.windows
            .filter(\.isKeyWindow).first
    }
}


