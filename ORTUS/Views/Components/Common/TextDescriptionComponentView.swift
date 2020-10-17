//
//  TextDescriptionComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class TextDescriptionComponentView: UIView {
    let textLabel = UILabel()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        addSubview(descriptionLabel)
        
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(descriptionLabel.snp.left).offset(-10).priority(250)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
