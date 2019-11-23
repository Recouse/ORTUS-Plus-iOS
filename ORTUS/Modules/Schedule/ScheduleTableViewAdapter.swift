//
//  ScheduleTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

protocol ScheduleTableViewAdapterDelegate: class {
    
}

class ScheduleTableViewAdapter: UITableViewAdapter {
    weak var delegate: ScheduleTableViewAdapterDelegate?
    
    init(delegate: ScheduleTableViewAdapterDelegate? = nil) {
        self.delegate = delegate
        
        super.init()
    }
    
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            let open = UIAction(
                title: "Open Link",
                image: UIImage(systemName: "link")
            ) { [unowned self] action in
                print("Link")
            }

            return UIMenu(title: "", children: [open])
        })
    }
}
