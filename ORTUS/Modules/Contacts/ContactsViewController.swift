//
//  ContactsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class ContactsViewController: ORTUSTableViewController, ModuleViewModel {
    var viewModel: ContactsViewModel
    
    weak var contactsView: ContactsView! { return view as? ContactsView }
    override var tableView: UITableView! { return contactsView.tableView }
    
    let toolbarSegmentedControl = UISegmentedControl()
    
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.delegate = self
        toolbar.isTranslucent = false

        let barItem = UIBarButtonItem(customView: self.toolbarSegmentedControl)

        toolbar.setItems([barItem], animated: false)

        return toolbar
    }()
    
    var selectedContactsFilter: Int = 0
        
    lazy var adapter = ContactsTableViewAdapter(delegate: self)
    
    lazy var contactsRenderer = Renderer(
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
        
        extendedLayoutIncludesOpaqueBars = true
        
        userActivity = Shortcut(activity: .contacts).activity
        
        EventLogger.log(.openedContacts)
        
        prepareNavigationItem()
        prepareToolbar()
        
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = nil
    }
    
    override func prepareData() {
        contactsRenderer.target = tableView
        contactsRenderer.updater.animatableChangeCount = 0
        
        adapter.didSelect = { [unowned self] context in
            guard let contact = context.node.component(as: ContactComponent.self)?.contact else {
                return
            }
            
            self.openContact(contact)
        }
    }
    
    func render() {
        contactsRenderer.render {
            Group(
                of: selectedContactsFilter ==  0 ? viewModel.prioritizedSortedKeys : viewModel.sortedKeys
            ) { key in
                Section(id: key, header: StickyHeader(title: key)) {
                    Group(
                        of: (selectedContactsFilter ==  0 ? viewModel.prioritizedContacts[key] : viewModel.contacts[key]) ?? []
                    ) { contact in
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
    
    @objc func filterContacts() {
        selectedContactsFilter = toolbarSegmentedControl.selectedSegmentIndex
        
        render()
    }
    
    override func refresh() {
        loadData()
    }
    
    func openContact(_ contact: Contact) {
        viewModel.router.openContact(contact)
    }
}

extension ContactsViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = L10n.Contacts.title
    }
    
    func prepareToolbar() {
        view.addSubview(toolbar)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        
        toolbarSegmentedControl.addTarget(self, action: #selector(filterContacts), for: .valueChanged)
        
        for (index, filter) in ContactsFilter.allCases.enumerated() {
            var filterString: String
            switch filter {
            case .all:
                filterString = L10n.Contacts.all
            case .my:
                filterString = L10n.Contacts.my
            }
            
            toolbarSegmentedControl.insertSegment(
                withTitle: filterString,
                at: index,
                animated: false)
        }
        toolbarSegmentedControl.selectedSegmentIndex = selectedContactsFilter
    }
}

extension ContactsViewController: UIToolbarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .top
    }
}

extension ContactsViewController: ContactsTableViewAdapterDelegate {
    func indexTitles() -> [String] {
        return selectedContactsFilter == 0 ? viewModel.prioritizedSortedKeys : viewModel.sortedKeys
    }
}

