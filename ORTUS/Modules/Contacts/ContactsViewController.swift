//
//  ContactsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Models

class ContactsViewController: TranslatableModule, ModuleViewModel {
    var viewModel: ContactsViewModel
    
    weak var contactsView: ContactsView! { return view as? ContactsView }
    weak var tableView: UITableView! { return contactsView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    lazy var adapter = ContactsTableViewAdapter(delegate: self)
    
    lazy var renderer = Renderer(
        adapter: self.adapter,
        updater: UITableViewUpdater()
    )
    
    init(viewModel: ContactsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ContactsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EventLogger.log(.openedContacts)
        
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        navigationItem.title = "contacts.title".localized()
    }
    
    func render() {
        renderer.render {
            Group(of: viewModel.sortedKeys) { key in
                Section(id: key, header: StickyHeader(title: key)) {
                    Group(of: viewModel.contacts[key] ?? []) { contact in
                        ContactComponent(id: contact.id, contact: contact)
                    }
                }
            }
        }
    }
    
    func loadData() {
        viewModel.loadContacts().always {
            self.refreshControl.endRefreshing()
            self.render()
        }
    }
    
    @objc func refresh() {
        loadData()
    }
    
    func openContact(_ contact: Contact) {
        viewModel.router.openContact(contact)
    }
}

extension ContactsViewController {
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
        
        adapter.didSelect = { [unowned self] context in
            guard let contact = context.node.component(as: ContactComponent.self)?.contact else {
                return
            }
            
            self.openContact(contact)
        }
    }
}

extension ContactsViewController: ContactsTableViewAdapterDelegate {
    func indexTitles() -> [String] {
        return viewModel.sortedKeys
    }
}

