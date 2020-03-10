//
//  TodayView.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 07/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import SnapKit

class TodayView: UIView {
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundView = nil
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
