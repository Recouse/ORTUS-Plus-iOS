//
//  GradesViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class GradesViewController: TranslatableModule, ModuleViewModel {
    var viewModel: GradesViewModel
    
    weak var gradesView: GradesView! { return view as? GradesView }
    weak var tableView: UITableView! { return gradesView.tableView }
    
    init(viewModel: GradesViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = GradesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventLogger.log(.openedGrades)
        
        prepareNavigationItem()
    }
    
    override func prepareLocales() {
        navigationItem.title = "grades.title".localized()
    }
}

extension GradesViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
}
