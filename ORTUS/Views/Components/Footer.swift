//
//  Footer.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 29/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct Footer: Carbon.Component, Equatable {
    var description: String = ""
    
    func renderContent() -> FooterView {
        return FooterView()
    }
    
    func render(in content: FooterView) {
        content.descriptionLabel.text = description
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
}

class FooterView: UIView {
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorCompatibility.secondaryLabel
        label.font = .systemFont(ofSize: 13)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().priority(250)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
