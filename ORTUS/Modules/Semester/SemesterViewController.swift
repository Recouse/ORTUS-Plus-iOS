//
//  SemesterViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class SemesterViewController: ORTUSTableViewController, ModuleViewModel {
    var viewModel: SemesterViewModel
    
    weak var semesterView: SemesterView! { return view as? SemesterView }
    
    var courseShortcut: Shortcut?
    
    override var tableView: UITableView! {
        return semesterView.tableView
    }
    
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
                        
        render()
    }
    
    override func prepareData() {
        super.prepareData()
        
        navigationItem.title = viewModel.semester.name ?? "Other"
        
        tableView.refreshControl = nil
        
        renderer.adapter.didSelect = { [unowned self] context in
            guard let course = context.node.id as? Course else {
                return
            }
            
            self.open(course: course)
        }
    }
    
    func render() {
        renderer.render {
            Section(id: "courses") {
                Group(of: viewModel.semester.courses) { course in
                    CourseComponent(course: course).identified(by: \.course)
                }
            }
        }
    }
    
    func open(course: Course) {        
        courseShortcut = Shortcut(
            activity: .course,
            identifier: .student,
            title: course.name,
            userInfo: ["url": course.link]
        )
        courseShortcut?.donate()
        
        viewModel.router.openBrowser(course.link)
    }
    
    override func separatorInset(forRowAt indexPath: IndexPath) -> UIEdgeInsets? {
        return UIEdgeInsets(top: 0, left: Global.UI.edgeInset + 40 + 15, bottom: 0, right: 0)
    }
}
