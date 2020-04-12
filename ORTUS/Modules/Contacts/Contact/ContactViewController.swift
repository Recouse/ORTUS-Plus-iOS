//
//  ContactViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit

class ContactViewController: Module, ModuleViewModel {
    var viewModel: ContactViewModel
    
    weak var ContactView: ContactView! { return view as? ContactView }
    
    init(viewModel: ContactViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ContactView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
