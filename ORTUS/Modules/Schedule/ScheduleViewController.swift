//
//  ScheduleViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class ScheduleViewController: TranslatableModule, ModuleViewModel {
    var viewModel: ScheduleViewModel
    
    weak var scheduleView: ScheduleView! { return view as? ScheduleView }
    
    init(viewModel: ScheduleViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScheduleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    
    override func prepareLocales() {
        title = "schedule.title".localized()
    }
}

