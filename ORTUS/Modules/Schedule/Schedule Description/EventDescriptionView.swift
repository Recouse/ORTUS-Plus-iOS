//
//  EventDescriptionView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/27/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class EventDescriptionView: UIView {
    let eventView = EventComponentView()
    
    static let descriptionFont = UIFont.systemFont(ofSize: 16)
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = EventDescriptionView.descriptionFont
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(eventView)
        eventView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(eventView.snp.bottom).offset(5)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(5).priority(250)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
