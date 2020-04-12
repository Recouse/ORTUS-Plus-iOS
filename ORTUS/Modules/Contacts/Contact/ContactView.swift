//
//  ContactView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/10/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit

class ContactView: UIView {
    let headerView: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .secondarySystemGroupedBackground
        } else {
            view.backgroundColor = .white
        }
        
        return view
    }()
    
    var headerHeight: NSLayoutConstraint!
    
    let photoView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.contentMode = .scaleAspectFill
        
        if #available(iOS 13.0, *) {
            imageView.backgroundColor = .systemGray3
        } else {
            imageView.backgroundColor = .lightGray
        }
        
        return imageView
    }()
    
    var photoViewTop: NSLayoutConstraint!
    
    let headerViewSeparator: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .separator
        } else {
            view.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        }
        
        return view
    }()
    
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
        
        if #available(iOS 13.0, *) {
            backgroundColor = .systemBackground
        } else {
            backgroundColor = .white
        }
        
        addSubview(headerView)
        headerHeight = headerView.heightAnchor.constraint(equalToConstant: 220)
        headerHeight.isActive = true
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        headerView.addSubview(photoView)
        photoViewTop = photoView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
        photoViewTop.isActive = true
        photoView.snp.makeConstraints {
            $0.size.equalTo(66)
            $0.centerX.equalToSuperview()
        }
        
        headerView.addSubview(headerViewSeparator)
        headerViewSeparator.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.equalTo(safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
