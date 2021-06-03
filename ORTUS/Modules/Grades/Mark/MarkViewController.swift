//
//  MarkViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class MarkViewController: Module, ModuleViewModel {
    enum ID {
        case cp, lector, type, date
    }
    
    var viewModel: MarkViewModel
    
    weak var markView: MarkView! { return view as? MarkView }
    weak var tableView: UITableView! { return markView.tableView }
    
    lazy var renderer = Renderer(
        adapter: ORTUSTableViewAdapter(selectionStyle: .none),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: MarkViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = MarkView()
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
                id: "mark",
                header: Header(title: "")
            ) {
                MarkComponent(mark: viewModel.mark).identified(by: viewModel.mark.id)
            }
            
            Section(
                id: "other",
                header: Header(title: "")
            ) {
                TextDescriptionComponent(
                    text: "CP",
                    description: viewModel.mark.creditPoints
                ).identified(by: ID.cp)
                
                TextDescriptionComponent(
                    text: "Lector",
                    description: viewModel.mark.lecturerFullName
                ).identified(by: ID.lector)
                
                TextDescriptionComponent(
                    text: "Type",
                    description: viewModel.mark.markType
                ).identified(by: ID.type)
                
                TextDescriptionComponent(
                    text: "Date",
                    description: formatDate(viewModel.mark.date ?? "")
                ).identified(by: ID.date)
            }
        }
    }
    
    func formatDate(_ date: String) -> String {
        let dateFormatter = LatviaDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        
        guard let parsedDate = dateFormatter.date(from: date) else {
            return date
        }
        
        dateFormatter.dateStyle = .long
        dateFormatter.doesRelativeDateFormatting = true
        
        return dateFormatter.string(from: parsedDate)
    }
}

extension MarkViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Details"
    }
    
    func prepareData() {
        renderer.target = tableView
    }
}
