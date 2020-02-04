//
//  NotificationsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class NotificationsViewController: TranslatableModule, ModuleViewModel {
    var viewModel: NotificationsViewModel
    
    weak var notificationsView: NotificationsView! { return view as? NotificationsView }
    weak var tableView: UITableView! { return notificationsView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    lazy var renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: NotificationsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NotificationsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        navigationItem.title = "notifications.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        renderer.render {
            Section(id: "notifications") {
                Group(of: viewModel.notifications) { notification in
                    NotificationComponent(
                        id: notification.id,
                        notification: notification,
                        onSelect: { [unowned self] in
                            self.open(notification)
                        }
                    )
                }
            }
        }
    }
    
    func loadData() {
        viewModel.loadNotifications().then { response in
            self.render()
        }.catch { error in
            print(error)
        }.always {
            self.render()
        }
    }
    
    @objc func refresh() {
        loadData()
    }
    
    @objc func scrollToTop() {
        guard let tabBarController = navigationController?.tabBarController,
            tabBarController.selectedIndex == Global.UI.TabBar.notifications.rawValue,
            !tableView.visibleCells.isEmpty else {
            return
        }
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func open(_ notification: NotificationModel) {
        viewModel.router.openBrowser(notification.link)
    }
}

extension NotificationsViewController {
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTop), name: .scrollToTop, object: nil)
    }
}

