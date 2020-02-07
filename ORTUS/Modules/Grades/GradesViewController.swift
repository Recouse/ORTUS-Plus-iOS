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
    
    var refreshControl: UIRefreshControl!
    
    lazy var renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
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
        
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        navigationItem.title = "grades.title".localized()
    }
    
    func render() {
        guard let semester = viewModel.studyPrograms.first?.semesters.first else {
            return
        }
                        
        renderer.render {
            Section(
                id: "grades",
                header: Header(title: semester.fullName.uppercased())
            ) {
                Group(of: semester.marks) { mark in
                    GradeComponent(id: mark.id, mark: mark)
                }
            }
        }
    }
    
    func loadData() {
        viewModel.loadMarks().always {
            self.refreshControl.endRefreshing()
            self.render()
        }
    }
    
    @objc func refresh() {
        loadData()
    }
}

extension GradesViewController {
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
    }
}
