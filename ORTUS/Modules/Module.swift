//
//  Module.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

typealias Module = UIViewController

protocol ModuleViewModel {
    associatedtype ViewModel
    
    var viewModel: ViewModel { get set }
}

protocol ViewModel {
    
}
