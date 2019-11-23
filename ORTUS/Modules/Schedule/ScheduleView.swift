//
//  ScheduleView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class ScheduleView: UIView {
    let toolbarSegmentedControl = UISegmentedControl()
    
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.delegate = self

        let barItem = UIBarButtonItem(customView: self.toolbarSegmentedControl)

        toolbar.setItems([barItem], animated: false)

        return toolbar
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundView = nil
        
        if #available(iOS 13.0, *) {
            tableView.backgroundColor = .secondarySystemBackground
        } else {
            tableView.backgroundColor = .groupTableViewBackground
        }
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0)
        tableView.contentInset = UIEdgeInsets(
            top: 44, // Toolbar height
            left: 0,
            bottom: 30,
            right: 0)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }

        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ScheduleView: UIToolbarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .top
    }
}
