//
//  InboxViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class InboxViewController: TranslatableModule, ModuleViewModel {
    var viewModel: InboxViewModel
    
    weak var inboxView: InboxView! { return view as? InboxView }
    weak var tableView: UITableView! { return inboxView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    lazy var renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: InboxViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = InboxView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        navigationItem.title = "inbox.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        var data: [Section] = []
        
        renderer.render(data)
    }
    
    func loadData() {
        viewModel.loadNotifications().then { response in
            print(self.viewModel.notifications)
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
            tabBarController.selectedIndex == Global.UI.TabBar.inbox.rawValue,
            !tableView.visibleCells.isEmpty else {
            return
        }
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension InboxViewController {
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
            
            //
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTop), name: .scrollToTop, object: nil)
    }
}

