//
//  Header.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct Header: Carbon.Component, Equatable {
    var title: String
    
    func renderContent() -> HeaderView {
        return HeaderView()
    }
    
    func render(in content: HeaderView) {
        content.titleLabel.text = title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class HeaderView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
