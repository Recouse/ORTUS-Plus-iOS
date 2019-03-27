//
//  ArticleHeaderComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class ArticleHeaderComponentView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(named: "lightGray")
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let imageViewOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 26)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareImageView()
        prepareTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleHeaderComponentView {
    func prepareImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        insertSubview(imageViewOverlay, aboveSubview: imageView)
        imageViewOverlay.snp.makeConstraints {
            $0.edges.equalTo(imageView)
        }
    }
    
    func prepareTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
//            $0.top.equalTo(safeAreaLayoutGuide).priority(250)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
