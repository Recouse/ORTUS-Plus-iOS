//
//  IconTextComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class IconTextComponentView: UIView {
    let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 7
        view.clipsToBounds = true
        
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        
        return label
    }()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevronRight")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tertiaryLabel
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(imageContainerView)
        imageContainerView.snp.makeConstraints {
            $0.size.equalTo(35)
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(imageContainerView).multipliedBy(0.65)
            $0.center.equalTo(imageContainerView)
        }
        
        addSubview(rightAccessoryView)
        rightAccessoryView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(imageContainerView.snp.right).offset(15)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
