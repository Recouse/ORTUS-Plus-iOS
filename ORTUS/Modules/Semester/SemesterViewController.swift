//
//  SemesterViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class SemesterViewController: TranslatableModule, ModuleViewModel {
    var viewModel: SemesterViewModel
    
    weak var semesterView: SemesterView! { return view as? SemesterView }
    weak var tableView: UITableView! { return semesterView.tableView }
    
    lazy var renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: SemesterViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SemesterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareData()
        
        render()
    }
    
    override func prepareLocales() {
        navigationItem.title = viewModel.semester.name ?? "Other"
    }
    
    func render() {
        renderer.render {
            Section(id: "courses", header: Header(title: "")) {
                Group(of: viewModel.semester.courses) { course in
                    CourseComponent(
                        id: course.id,
                        course: course,
                        onSelect: { [unowned self] in
                            self.open(course: course)
                        }
                    ).identified(by: \.course.id)
                }
            }
        }
    }
    
    func open(course: Course) {
        EventLogger.log(.openedCourse(id: course.id, name: course.name))
        
        viewModel.router.openBrowser(course.link)
    }
}

extension SemesterViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func prepareData() {
        renderer.target = tableView
    }
}
