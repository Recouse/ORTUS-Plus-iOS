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
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = Asset.Colors.lightGray.color
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.darkGray.color
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareImageView()
        prepareAuthorLabel()
        prepareTitleLabel()
        
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
            $0.top.bottom.equalToSuperview().offset(15).inset(15)
            $0.width.equalTo(imageView.snp.height)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
    }
    
    func prepareAuthorLabel() {
        addSubview(authorLabel)
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(imageView)
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    func prepareTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.left.equalTo(imageView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
            $0.bottom.equalTo(imageView).priority(250)
        }
    }
}
