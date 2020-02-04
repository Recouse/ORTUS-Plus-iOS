//
//  CoursesViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import SafariServices

class CoursesViewController: TranslatableModule, ModuleViewModel {
    var viewModel: CoursesViewModel
    
    weak var coursesView: CoursesView! { return view as? CoursesView }
    weak var tableView: UITableView! { return coursesView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
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
        
        prepareNavigationItem()
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        title = "courses.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()

        renderer.render {
            Group(of: viewModel.semesters) { semester in
                Section(
                    id: semester.name ?? "",
                    header: Header(title: semester.name?.uppercased() ?? ""),
                    cells: {
                        Group(of: semester.courses) { course in
                            CourseComponent(
                                id: course.id,
                                course: course,
                                onSelect: { [unowned self] in
                                    self.open(course: course)
                                }
                            ).identified(by: \.course.id)
                        }
                    }
                )
            }
        }
    }
    
    func loadData() {
        viewModel.loadCourses().catch { error in
            print(error)
        }.always {
            self.render()
        }
    }
    
    func open(course: Course) {
        EventLogger.log(.openedCourse(id: course.id, name: course.name))
        
        viewModel.router.openBrowser(course.link)
    }
    
    @objc func refresh() {
        loadData()
    }
}

extension CoursesViewController {
    func prepareNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "", style: .plain, target: nil, action: nil)
    }
    
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
    }
}

extension CoursesViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

