//
//  NotificationsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
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
        
        navigationItem.title = L10n.Notifications.title
        
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
    
    func render() {
        refreshControl.endRefreshing()
        
        var section: Section
        
        section = Section(id: "notifications") {
            Group(of: viewModel.notifications) { notification in
                NotificationComponent(notification: notification).identified(by: notification.id)
            }
        }
        
        if viewModel.notifications.isEmpty {
            section = Section(id: "empty", header: ViewNode(
                StateComponent(
                    image: Asset.Images.emptyInboxFlatline.image,
                    primaryText: "No new notifications",
                    secondaryText: "Check later or pull to refresh.",
                    height: view.safeAreaLayoutGuide.layoutFrame.height - 44 - 25
                )
            ))
        }
        
        renderer.render(section)
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
        viewModel.router.openBrowser(notification.link)
    }
}

