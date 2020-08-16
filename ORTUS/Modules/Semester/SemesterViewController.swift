//
//  SemesterViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

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
        
        EventLogger.log(.openedSemester(name: viewModel.semester.name ?? "Other"))
                
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
        EventLogger.log(.openedCourse(id: course.id, name: course.name))
        
        courseShortcut = Shortcut(
            activity: .course,
            identifier: .student,
            title: course.name,
            userInfo: ["url": course.link]
        )
        courseShortcut?.donate()
        
        viewModel.router.openBrowser(course.link)
    }
}
