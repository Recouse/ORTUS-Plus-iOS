//
//  ContactsTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

protocol ContactsTableViewAdapterDelegate: AnyObject {
    func indexTitles() -> [String]
}

class ContactsTableViewAdapter: ORTUSTableViewAdapter {
    weak var delegate: ContactsTableViewAdapterDelegate?
    
    init(delegate: ContactsTableViewAdapterDelegate?) {
        self.delegate = delegate
        
        super.init()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return delegate?.indexTitles()
    }
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
//    @available(iOS 13.0, *)
//    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
//        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
//            let open = UIAction(
//                title: "Send Email",
//                image: UIImage(systemName: "envelope")
//            ) { [unowned self] action in
//                print("Email")
//            }
//
//            return UIMenu(title: "", children: [open])
//        })
//    }
}
