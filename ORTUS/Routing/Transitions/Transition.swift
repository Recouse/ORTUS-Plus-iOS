//
//  Transition.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import Foundation
import UIKit

protocol Transition: class {
    var viewController: UIViewController? { get set }
    
    func open(_ viewController: UIViewController, completion: (() -> Void)?)
    func close(_ viewController: UIViewController)
}
