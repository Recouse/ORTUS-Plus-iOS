//
//  CoursesViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class CoursesViewController: TranslatableModule, ModuleViewModel {
    var viewModel: CoursesViewModel
    
    weak var coursesView: CoursesView! { return view as? CoursesView }
    
    init(viewModel: CoursesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CoursesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func prepareLocales() {
        title = "courses.title".localized()
    }
}

