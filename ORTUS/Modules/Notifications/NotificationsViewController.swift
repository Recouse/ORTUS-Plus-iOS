//
//  NotificationsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models
import Promises

class NotificationsViewController: ORTUSTableViewController, ModuleViewModel {
    var viewModel: NotificationsViewModel
    
    weak var notificationsView: NotificationsView! { return view as? NotificationsView }
    override var tableView: UITableView! { return notificationsView.tableView }
    
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
        
        loadData()
    }
    
    override func prepareData() {
        super.prepareData()
        
        renderer.adapter.didSelect = { [unowned self] context in
            let notification = self.viewModel.notifications[context.indexPath.row]
            
            self.open(notification)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(scrollToTop),
            name: .scrollToTop,
            object: nil
        )
    }
    
    override func prepareLocales() {
        navigationItem.title = "notifications.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        renderer.render {
            Section(id: "notifications") {
                Group(of: viewModel.notifications) { notification in
                    NotificationComponent(notification: notification).identified(by: notification.id)
                }
            }
        }
    }
    
    func loadData(forceUpdate: Bool = false) {
        if forceUpdate {
            viewModel.loadNotifications().always {
                self.render()
            }
            
            return
        }
        
        viewModel.loadCachedNotifications().then { _ -> Promise<Bool> in
            self.render()
            
            return self.viewModel.loadNotifications()
        }.then { _ in
            self.render()
        }
    }
    
    override func refresh() {
        loadData(forceUpdate: true)
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
        EventLogger.log(.openedNotification)
        
        viewModel.router.openBrowser(notification.link)
    }
}

