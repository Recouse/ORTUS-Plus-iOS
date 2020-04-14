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
        view.backgroundColor = ColorCompatibility.secondarySystemGroupedBackground
        
        return view
    }()
    
    var headerHeight: NSLayoutConstraint!
    
    let photoView: CircleImageView = {
        let imageView = CircleImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = ColorCompatibility.systemGray4
        
        return imageView
    }()
        
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        
        return label
    }()
    
    let emailButton: CircleButton = {
        let button = CircleButton(style: ButtonsStyle.action)
        button.setImage(UIImage(named: "envelopeFill")?.tint(with: .white), for: .normal)
        button.setImage(UIImage(named: "envelopeFill")?.tint(with: .white), for: .highlighted)
        button.isEnabled = false
        
        return button
    }()
    
    let callButton: CircleButton = {
        let button = CircleButton(style: ButtonsStyle.action)
        button.setImage(UIImage(named: "phoneFill")?.tint(with: .white), for: .normal)
        button.setImage(UIImage(named: "phoneFill")?.tint(with: .white), for: .highlighted)
        button.isEnabled = false
        
        return button
    }()
    
    let directionsButton: CircleButton = {
        let button = CircleButton(style: ButtonsStyle.action)
        button.setImage(UIImage(named: "mapFill")?.tint(with: .white), for: .normal)
        button.setImage(UIImage(named: "mapFill")?.tint(with: .white), for: .highlighted)
        button.isEnabled = false
        
        return button
    }()
    
    lazy var actionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.emailButton, self.callButton, self.directionsButton
        ])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        
        return stackView
    }()
    
    var actionsHeight: NSLayoutConstraint!
    
    let headerViewSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = ColorCompatibility.separator
        
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
        
        backgroundColor = ColorCompatibility.systemBackground
        
        addSubview(headerView)
        headerHeight = headerView.heightAnchor.constraint(equalToConstant: Global.UI.isIphoneX ? 240 : 210)
        headerHeight.isActive = true
        headerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        headerView.addSubview(photoView)
        photoView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(-39).priority(250)
            $0.top.equalTo(safeAreaLayoutGuide).priority(750)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.width.equalTo(photoView.snp.height)
            $0.centerX.equalToSuperview()
        }
        
        headerView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(photoView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
        }
        
        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(actionsStackView)
        actionsHeight = actionsStackView.heightAnchor.constraint(equalToConstant: 40)
        actionsHeight.isActive = true
        actionsStackView.snp.makeConstraints {
//            $0.height.equalTo(40)
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
//            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        emailButton.snp.makeConstraints {
            $0.size.equalTo(40)
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
