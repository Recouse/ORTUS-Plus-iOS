//
//  Animator.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

protocol Animator: UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
}
