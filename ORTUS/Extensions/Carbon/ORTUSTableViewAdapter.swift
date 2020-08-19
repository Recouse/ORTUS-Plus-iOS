//
//  ORTUSTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 6/17/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class ORTUSTableViewAdapter: UITableViewAdapter {
    let selectionStyle: UITableViewCell.SelectionStyle
    
    init(selectionStyle: UITableViewCell.SelectionStyle = .default) {
        self.selectionStyle = selectionStyle
        
        super.init()
    }
    
    override func cellRegistration(tableView: UITableView, indexPath: IndexPath, node: CellNode) -> CellRegistration {
        switch selectionStyle {
        case .none:
            return CellRegistration(class: ORTUSSelectionNoneTableViewCell.self)
        default:
            return CellRegistration(class: ORTUSTableViewCell.self)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
    }
}
