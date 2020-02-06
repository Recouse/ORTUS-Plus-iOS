//
//  ScheduleSettingsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class ScheduleSettingsViewController: TranslatableModule, ModuleViewModel {
    var viewModel: ScheduleSettingsViewModel
    
    weak var scheduleSettingsView: ScheduleSettingsView! { return view as? ScheduleSettingsView }
    weak var tableView: UITableView! { return scheduleSettingsView.tableView }
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: ScheduleSettingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = ScheduleSettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareData()
        
        render()
    }
    
    override func prepareLocales() {
        navigationItem.title = "Schedule"
    }
    
    func render() {
        renderer.render {
            Section(
                id: "events",
                header: Header(title: ""),
                footer: Footer(description: "When selected, events will be shown with lectures in Schedule."),
                cells: {
                    FormSwitch(
                        title: "Show Events",
                        isOn: UserDefaults.standard.value(for: .showEvents) ?? false,
                        onSwitch: { isOn in
                            UserDefaults.standard.set(isOn, for: .showEvents)
                        }
                    )
                }
            )
        }
    }
}

extension ScheduleSettingsViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func prepareData() {
        renderer.target = tableView
    }
}
