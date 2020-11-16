//
//  ArticleComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class ArticleComponentView: UIControl {
    var onSelect: (() -> Void)?
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .caption1).bold()
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 3
        
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.lightGray.color
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemGroupedBackground
        
        addSubview(authorLabel)
        addSubview(titleLabel)
        addSubview(imageView)
        addSubview(dateLabel)
        
        prepareImageView()
        prepareAuthorLabel()
        prepareTitleLabel()
        prepareDateLabel()
        
        addTarget(self, action: #selector(selected), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selected() {
        onSelect?()
    }
}

extension ArticleComponentView {
    func prepareImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(80)
            $0.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    func prepareAuthorLabel() {
        addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Global.UI.edgeInset)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(imageView.snp.left).offset(-10)
        }
    }
    
    func prepareTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(2)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(imageView.snp.left).offset(-10)
        }
    }
    
    func prepareDateLabel() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
}
