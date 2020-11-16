//
//  ORTUSTableViewAdapter.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 6/17/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

protocol ORTUSTableViewAdapterDelegate: AnyObject {
    @available(iOS 13.0, *)
    func contextMenuConfiguration(
        forRowAt indexPath: IndexPath,
        point: CGPoint
    ) -> UIContextMenuConfiguration?
    
    @available(iOS 13.0, *)
    func willPerformPreviewActionForMenu(
        configuration: UIContextMenuConfiguration,
        animator: UIContextMenuInteractionCommitAnimating
    )
    
    func separatorInset(forRowAt indexPath: IndexPath) -> UIEdgeInsets?
}

class ORTUSTableViewAdapter: UITableViewAdapter {
    weak var delegate: ORTUSTableViewAdapterDelegate?
    
    let selectionStyle: UITableViewCell.SelectionStyle
    
    init(
        delegate: ORTUSTableViewAdapterDelegate? = nil,
        selectionStyle: UITableViewCell.SelectionStyle = .default
    ) {
        self.delegate = delegate
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
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let separatorInset = delegate?.separatorInset(forRowAt: indexPath) {
            cell.separatorInset = separatorInset
        }
        
        return cell
    }
    
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        delegate?.contextMenuConfiguration(forRowAt: indexPath, point: point)
    }
    
    @available(iOS 13.0, *)
    func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        delegate?.willPerformPreviewActionForMenu(configuration: configuration, animator: animator)
    }
}
