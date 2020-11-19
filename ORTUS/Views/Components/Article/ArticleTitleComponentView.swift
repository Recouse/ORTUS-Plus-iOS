//
//  ArticleTitleComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 11/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class ArticleTitleComponentView: UIView {
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .subheadline, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        label.numberOfLines = 0
        
        return label
    }()
    
    let dateIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "calendar")
        imageView.tintColor = .tertiaryLabel
        
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .subheadline, weight: .medium)
        label.textColor = .tertiaryLabel
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
        }
        
        addSubview(dateIconView)
        dateIconView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview()
        }
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateIconView)
            $0.left.equalTo(dateIconView.snp.right).offset(5)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
