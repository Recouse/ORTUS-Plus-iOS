//
//  SettingsView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundView = nil
        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .noe
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
