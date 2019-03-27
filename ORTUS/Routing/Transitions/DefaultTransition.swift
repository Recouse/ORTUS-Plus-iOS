//
//  DefaultTransition.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class DefaultTransition: NSObject {
    var animator: Animator?
    var isAnimated: Bool = true
    
    weak var viewController: UIViewController?
    
    init(animator: Animator? = nil,
         isAnimated: Bool = true) {
        self.animator = animator
        self.isAnimated = isAnimated
    }
}

// MARK: - Transition

extension DefaultTransition: Transition {
    func open(_ viewController: UIViewController, completion: (() -> Void)?) {
        self.viewController?.present(viewController, animated: isAnimated, completion: completion)
    }
    
    func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: isAnimated)
    }
}
