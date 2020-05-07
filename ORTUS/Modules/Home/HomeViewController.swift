//
//  HomeViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Promises

class HomeViewController: TranslatableModule, ModuleViewModel {
    enum ID: String {
        case news, grades, contacts, ortus
    }
    
    var viewModel: HomeViewModel
    
    weak var homeView: HomeView! { return view as? HomeView }
    weak var tableView: UITableView! { return homeView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    lazy var renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = HomeView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        navigationItem.title = "home.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        renderer.render {
            Section(id: "overview", header: Header(title: "Overview".uppercased()), cells: {
                IconTextComponent(
                    id: ID.news.rawValue,
                    title: "News",
                    icon: Asset.Images.news.image,
                    color: .systemPurple
                ) { [unowned self] in
                    self.viewModel.router.openNews()
                }
                
                IconTextComponent(
                    id: ID.grades.rawValue,
                    title: "Grades",
                    icon: Asset.Images.ten.image,
                    color: .systemBlue
                ) { [unowned self] in
                    self.viewModel.router.openGrades()
                }
                
                IconTextComponent(
                    id: ID.contacts.rawValue,
                    title: "Contacts",
                    icon: UIImage(named: "personCircle"),
                    color: .systemOrange
                ) { [unowned self] in
                    self.viewModel.router.openContacts()
                }
                
                IconTextComponent(
                    id: ID.ortus.rawValue,
                    title: "ORTUS Website",
                    icon: Asset.Images.ortusLogo.image,
                    color: .systemGreen
                ) { [unowned self] in
                    self.viewModel.router.openBrowser(Global.ortusURL)
                }
            })
            
            Section(id: "courses", header: Header(title: "Courses".uppercased()), cells: {
                Group(of: viewModel.semesters) { semester in
                    TextComponent(
                        id: semester.name ?? "other",
                        text: semester.name ?? "Other"
                    ) { [unowned self] in
                        self.viewModel.router.openSemester(semester)
                    }
                }
            })
        }
    }
    
    func loadData() {
        viewModel.loadCachedCourses().then { _ -> Promise<Bool> in
            self.render()
            
            return self.viewModel.loadCourses()
        }.always {
            self.render()
        }
    }
    
    @objc func refresh() {
        loadData()
    }
    
    @objc func scrollToTop() {
        guard let tabBarController = navigationController?.tabBarController,
            tabBarController.selectedIndex == Global.UI.TabBar.home.rawValue,
            !tableView.visibleCells.isEmpty else {
            return
        }
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func openSettings() {
        viewModel.router.openSettings()
    }
}

extension HomeViewController {
    func prepareNavigationItem() {
        var settingsImage: UIImage?
        
        if #available(iOS 13.0, *) {
            settingsImage = UIImage(systemName: "gear")
        } else {
            settingsImage = Asset.Images.settings.image
        }
        
        let settingsItem = UIBarButtonItem(
            image: settingsImage,
            style: .plain,
            target: self,
            action: #selector(openSettings))
        navigationItem.rightBarButtonItem = settingsItem
    }
    
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
        renderer.updater.isAnimationEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTop), name: .scrollToTop, object: nil)
    }
}
