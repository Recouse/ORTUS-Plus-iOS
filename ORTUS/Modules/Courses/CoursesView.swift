//
//  CoursesView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class CoursesView: UIView {
    let tableView: UITableView = {
        var style: UITableView.Style = .grouped
        
        if #available(iOS 13.0, *) {
            style = .insetGrouped
        }
        
        let tableView = UITableView(frame: .zero, style: style)
        tableView.backgroundView = nil
        tableView.backgroundColor = .groupTableViewBackground
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(
            top: 0,
            left: Global.UI.edgeInset + 40 + 15,
            bottom: 0,
            right: 0)
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorCompatibility.systemBackground
        
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
