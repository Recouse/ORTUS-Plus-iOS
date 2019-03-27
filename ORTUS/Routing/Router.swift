//
//  Router.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

protocol Closable: class {
    func close()
}

protocol RouterProtocol: class {
    associatedtype V: UIViewController
    var viewController: V? { get }
    var completion: (() -> Void)? { get set }
    
    func open(_ viewController: UIViewController, transition: Transition, completion: (() -> Void)?)
}

class Router<U>: RouterProtocol, Closable where U: UIViewController {
    typealias V = U
    
    weak var viewController: V?
    var completion: (() -> Void)?
    var openTransition: Transition?
    
    func open(_ viewController: UIViewController, transition: Transition, completion: (() -> Void)? = nil) {
        transition.viewController = self.viewController
        transition.open(viewController, completion: completion)
    }
    
    func close() {
        guard let openTransition = openTransition else {
            assertionFailure("You should specify an open transition in order to close a module.")
            return
        }
        guard let viewController = viewController else {
            assertionFailure("Nothing to close.")
            return
        }
        openTransition.close(viewController)
    }
}
