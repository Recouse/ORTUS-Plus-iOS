//
//  ContactInfoComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/13/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class ContactInfoComponentView: UIView {
    let contentLayoutGuide = UILayoutGuide()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = ColorCompatibility.label
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Asset.Colors.tintColor.color
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorCompatibility.secondarySystemGroupedBackground
        
        addLayoutGuide(contentLayoutGuide)
        contentLayoutGuide.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(10).inset(10)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentLayoutGuide)
            $0.left.right.equalTo(contentLayoutGuide)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.left.right.equalTo(contentLayoutGuide)
            $0.bottom.equalTo(contentLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
