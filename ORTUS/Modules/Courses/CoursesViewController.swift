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
    
    lazy var renderer = Renderer(
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
        
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        title = "courses.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        var data: [Section] = []
        
        for semester in viewModel.semesters {
            data.append(
                Section(
                    id: semester.name ?? "",
                    header: ViewNode(Header(title: semester.name?.uppercased() ?? "")),
                    cells: semester.courses.map {
                        CellNode(CourseComponent(id: $0.id, course: $0))
                    }
                )
            )
        }
        
        renderer.render(data)
    }
    
    func loadData() {
        viewModel.loadCourses().catch { error in
            print(error)
        }.always {
            self.render()
        }
    }
    
    func open(course: Course) {
        guard let url = course.link.generatePinAuthURL() else {
            return
        }
        
        let safariController = SFSafariViewController(url: url)
        safariController.delegate = self
        
        present(safariController, animated: true, completion: nil)
    }
    
    @objc func refresh() {
        loadData()
    }
    
    @objc func scrollToTop() {
        guard let tabBarController = navigationController?.tabBarController,
            tabBarController.selectedIndex == Global.UI.TabBar.courses.rawValue,
            !tableView.visibleCells.isEmpty else {
            return
        }
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension CoursesViewController {
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
        renderer.adapter.didSelect = { [unowned self] context in
            guard let component = context.node.component(as: CourseComponent.self) else {
                return
            }
            
            self.open(course: component.course)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTop), name: .scrollToTop, object: nil)
    }
}

extension CoursesViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

