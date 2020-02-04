//
//  NotificationComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 03/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class NotificationComponentView: UIControl {
    var onSelect: (() -> Void)?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.numberOfLines = 2
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .gray
        }
        label.font = .systemFont(ofSize: 16)
        
        return label
    }()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.chevronRight.image
        imageView.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            imageView.tintColor = .separator
        } else {
            imageView.tintColor = .gray
        }
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemGroupedBackground
        } else {
            backgroundColor = .white
        }
        
        addSubview(rightAccessoryView)
        rightAccessoryView.snp.makeConstraints {
            $0.size.equalTo(14)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(10)
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        addTarget(self, action: #selector(selected), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selected() {
        onSelect?()
    }
}
