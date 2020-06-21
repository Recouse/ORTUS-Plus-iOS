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
import Models

class HomeViewController: ORTUSTableViewController, ModuleViewModel {
    enum ID {
        case news, grades, contacts, ortus
    }
    
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        
        loadData()
    }
    
    override func prepareLocales() {
        navigationItem.title = "home.title".localized()
    }
    
    override func prepareData() {
        super.prepareData()
        
        renderer.updater.animatableChangeCount = 0
        
        renderer.adapter.didSelect = { [unowned self] context in
            if let id = context.node.id as? ID {
                switch id {
                case .news:
                    self.viewModel.router.openNews()
                case .grades:
                    self.viewModel.router.openGrades()
                case .contacts:
                    self.viewModel.router.openContacts()
                case .ortus:
                    self.viewModel.router.openBrowser(Global.ortusURL)
                }
            } else if let index = context.node.id as? Int {
                self.viewModel.router.openSemester(self.viewModel.semesters[index])
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(scrollToTop),
            name: .scrollToTop,
            object: nil
        )
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        renderer.render {
            Section(id: "overview", header: Header(title: "Overview".uppercased()), cells: {
                IconTextComponent(
                    title: "News",
                    icon: Asset.Images.news.image,
                    color: .systemPurple
                ).identified(by: ID.news)
                
                IconTextComponent(
                    title: "Grades",
                    icon: Asset.Images.ten.image,
                    color: .systemBlue
                ).identified(by: ID.grades)
                
                IconTextComponent(
                    title: "Contacts",
                    icon: UIImage(named: "personCircle"),
                    color: .systemOrange
                ).identified(by: ID.contacts)
                
                IconTextComponent(
                    title: "ORTUS Website",
                    icon: Asset.Images.ortusLogo.image,
                    color: .systemGreen
                ).identified(by: ID.ortus)
            })
            
            Section(id: "courses", header: Header(title: "Courses".uppercased()), cells: {
                Group(of: viewModel.semesters.enumerated()) { (index, semester) in
                    TextComponent(
                        text: semester.name ?? "Other"
                    ).identified(by: index)
                }
            })
        }
    }
    
    func loadData(forceUpdate: Bool = false) {
        if forceUpdate {
            viewModel.loadCourses().always {
                self.render()
            }
            
            return
        }
        
        viewModel.loadCachedCourses().then { _ -> Promise<Bool> in
            self.render()
            
            return self.viewModel.loadCourses()
        }.then { _ in
            self.render()
        }
    }
    
    override func refresh() {
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
}
