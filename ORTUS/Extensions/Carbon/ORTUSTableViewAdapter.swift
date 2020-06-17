//
//  ORTUSTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 6/17/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

final class ORTUSTableViewAdapter: UITableViewAdapter {
    override func cellRegistration(tableView: UITableView, indexPath: IndexPath, node: CellNode) -> CellRegistration {
        CellRegistration(class: ORTUSTableViewCell.self)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        super.tableView(tableView, cellForRowAt: indexPath)
    }
}
