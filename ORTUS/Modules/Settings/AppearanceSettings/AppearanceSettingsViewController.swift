//
//  AppearanceSettingsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/12/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class AppearanceSettingsViewController: Module, ModuleViewModel {
    enum ID {
        case system, light, dark
    }
    
    var viewModel: AppearanceSettingsViewModel
    
    weak var appearanceSettingsView: AppearanceSettingsView! { return view as? AppearanceSettingsView }
    weak var tableView: UITableView! { return appearanceSettingsView.tableView }
    
    let renderer = Renderer(
        adapter: ORTUSTableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    var selectedIndexPath: IndexPath?
    
    init(viewModel: AppearanceSettingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AppearanceSettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareData()
        
        render()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        preselectAppearance()
    }
    
    func render() {
        renderer.render {
            Section(
                id: "appearance",
                header: Header(title: ""),
                cells: {
                    FormSelect(title: "System").identified(by: ID.system)
                    FormSelect(title: "Light").identified(by: ID.light)
                    FormSelect(title: "Dark").identified(by: ID.dark)
                }
            )
        }
    }
    
    func preselectAppearance() {
        guard selectedIndexPath == nil else {
            return
        }
        
        var indexPath: IndexPath
        
        let appearance = UserDefaults.standard.value(for: .appearance)
        
        switch appearance {
        case "system":
            indexPath = IndexPath(row: 0, section: 0)
        case "light":
            indexPath = IndexPath(row: 1, section: 0)
        case "dark":
            indexPath = IndexPath(row: 2, section: 0)
        default:
            // Select system
            indexPath = IndexPath(row: 0, section: 0)
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedIndexPath = indexPath
    }
    
    func selectAppearance(id: AnyHashable) {
        guard let appearance = id as? ID else {
            return
        }
        
        switch appearance {
        case .system:
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
            UserDefaults.standard.set("system", for: .appearance)
        case .light:
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
            UserDefaults.standard.set("light", for: .appearance)
        case .dark:
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set("dark", for: .appearance)
        }
    }
    
    func deselectSelectedRow() {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {
            return
        }
        
        tableView.deselectRow(at: selectedIndexPath, animated: true)
    }
}

extension AppearanceSettingsViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.title = "Appearance"
    }
    
    func prepareData() {
        renderer.target = tableView
        
        renderer.adapter.didSelect = { [unowned self] context in
            self.deselectSelectedRow()
            
            guard self.selectedIndexPath != context.indexPath else {
                return
            }
            
            if let selectedIndexPath = self.selectedIndexPath {
                self.tableView.cellForRow(at: selectedIndexPath)?.accessoryType = .none
            }
            
            self.tableView.cellForRow(at: context.indexPath)?.accessoryType = .checkmark
            self.selectedIndexPath = context.indexPath
            
            self.selectAppearance(id: context.node.id)
        }
    }
}
