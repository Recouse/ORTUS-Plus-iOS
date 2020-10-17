//
//  NotificationsView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/10/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class NotificationsView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundView = nil
        tableView.backgroundColor = .groupTableViewBackground
        tableView.separatorStyle = .singleLine
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalTo(safeAreaLayoutGuide)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
