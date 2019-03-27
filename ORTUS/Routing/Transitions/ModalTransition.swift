//
//  ModalTransition.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class ModalTransition: NSObject {
    var animator: Animator?
    var isAnimated: Bool = true
    
    var modalTransitionStyle: UIModalTransitionStyle
    var modalPresentationStyle: UIModalPresentationStyle
    
    weak var viewController: UIViewController?
    
    init(animator: Animator? = nil,
         isAnimated: Bool = true,
         modalTransitionStyle: UIModalTransitionStyle = .coverVertical,
         modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        self.animator = animator
        self.isAnimated = isAnimated
        self.modalTransitionStyle = modalTransitionStyle
        self.modalPresentationStyle = modalPresentationStyle
    }
}

// MARK: - Transition

extension ModalTransition: Transition {
    func open(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.transitioningDelegate = self
        viewController.modalTransitionStyle = modalTransitionStyle
        viewController.modalPresentationStyle = modalPresentationStyle
        
        self.viewController?.present(viewController, animated: isAnimated, completion: completion)
    }
    
    func close(_ viewController: UIViewController) {
        viewController.dismiss(animated: isAnimated)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension ModalTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = true
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let animator = animator else {
            return nil
        }
        animator.isPresenting = false
        return animator
    }
}
