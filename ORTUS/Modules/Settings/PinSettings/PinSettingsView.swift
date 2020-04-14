//
//  PinSettingsView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 31/01/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit

class PinSettingsView: UIView {
    let tableView: UITableView = {
        var style: UITableView.Style = .grouped
        
        if #available(iOS 13.0, *) {
            style = .insetGrouped
        }
        
        let tableView = UITableView(frame: .zero, style: style)
        tableView.backgroundView = nil
        tableView.backgroundColor = .groupTableViewBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorCompatibility.systemBackground
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
