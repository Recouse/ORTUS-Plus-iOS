//
//  ModuleBuilder.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

protocol ModuleBuilder: AnyObject {
    associatedtype M // Module Type
    associatedtype P // Parameter Types
    
    static func build(with parameter: P, customTransition transition: Transition?) -> M
}
