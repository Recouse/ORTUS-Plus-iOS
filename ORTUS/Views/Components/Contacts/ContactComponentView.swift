//
//  ContactComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class ContactComponentView: UIView {
    let nameLabel = UILabel()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemGroupedBackground
        } else {
            backgroundColor = .white
        }
        
        addSubview(photoView)
        photoView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(5).inset(5)
            $0.width.equalTo(photoView.snp.height)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(photoView.snp.right).offset(10)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
