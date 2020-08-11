//
//  PinSettingsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 31/01/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class PinSettingsViewController: Module, ModuleViewModel, AlertPresentable {
    enum ID {
        case pinCode
    }

    var viewModel: PinSettingsViewModel
    
    weak var pinSettingsView: PinSettingsView! { return view as? PinSettingsView }
    weak var tableView: UITableView! { return pinSettingsView.tableView }
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    var pinCode: String?
    
    init(viewModel: PinSettingsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = PinSettingsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareData()
        
        render()
    }
    
    func render() {
        renderer.render {
            Section(
                id: "pin",
                header: Header(title: ""),
                footer: Footer(description: "Enter your ORTUS PIN code."),
                cells: {
                    FormTextField(
                        title: "PIN",
                        text: viewModel.keychain[Global.Key.ortusPinCode],
                        isSecureTextEntry: true,
                        keyboardType: .numberPad,
                        onInput: { [unowned self] text in
                            self.pinCode = text
                        }
                    )
                }
            )
        }
    }
    
    @objc func save() {
        guard let pinCode = pinCode else {
            return
        }
        
        guard pinCode.count == 4 else {
            self.alert(message: "PIN code must be a 4-digit")
            return
        }
        
        view.endEditing(true)
        
        viewModel.save(pinCode)
        viewModel.router.close()
    }
}

extension PinSettingsViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        
        let saveItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveItem
        
        navigationItem.title = "PIN Code"
    }
    
    func prepareData() {
        renderer.target = tableView
    }
}
