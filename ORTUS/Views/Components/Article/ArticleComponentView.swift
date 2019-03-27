//
//  ArticleComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class ArticleComponentView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(named: "lightGray")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "darkGray")
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "gray")
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareImageView()
        prepareAuthorLabel()
        prepareTitleLabel()
        prepareSeparatorView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func prepareSeparatorView() {
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
