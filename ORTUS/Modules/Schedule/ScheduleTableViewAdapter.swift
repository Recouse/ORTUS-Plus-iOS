//
//  ScheduleTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

protocol ScheduleTableViewAdapterDataSource: class {
    func item(for indexPath: IndexPath) -> ScheduleItem?
}

protocol ScheduleTableViewAdapterDelegate: class {
    func openLink(_ url: URL)
}

class ScheduleTableViewAdapter: UITableViewAdapter {
    weak var dataSource: ScheduleTableViewAdapterDataSource?
    
    weak var delegate: ScheduleTableViewAdapterDelegate?
    
    init(
        dataSource: ScheduleTableViewAdapterDataSource? = nil,
        delegate: ScheduleTableViewAdapterDelegate? = nil
    ) {
        self.dataSource = dataSource
        self.delegate = delegate
        
        super.init()
    }
    
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard let scheduleItem = dataSource?.item(for: indexPath) else {
            return nil
        }
        
        var previewProvider: UIContextMenuContentPreviewProvider?
        var actionProdivder: UIContextMenuActionProvider?
        
        if let event = scheduleItem.item(as: Event.self) {
            previewProvider = {
                return EventDescriptionViewController(event: event)
            }
            
            actionProdivder = { _ in
                let open = UIAction(
                    title: "Open Link",
                    image: UIImage(systemName: "link")
                ) { [weak self] action in
                    guard let url = URL(string: event.link) else {
                        return
                    }
                    
                    self?.delegate?.openLink(url)
                }

                return UIMenu(title: "", children: [open])
            }
        }

        if scheduleItem.item(as: Lecture.self) != nil {
            return nil
        }
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: previewProvider,
            actionProvider: actionProdivder
        )
    }
}
