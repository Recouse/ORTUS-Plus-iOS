//
//  TextComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class TextComponentView: UIControl {
    var onSelect: (() -> Void)?
    
    let textLabel = UILabel()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.chevronRight.image
        imageView.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            imageView.tintColor = .tertiaryLabel
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
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(10)
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
