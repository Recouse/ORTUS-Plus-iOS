//
//  VersionComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class VersionComponentView: UIControl {
    var onSelect: (() -> Void)?
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textAlignment = .center
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .lightGray
        }
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.right.equalToSuperview()
                .offset(Global.UI.edgeInset)
                .inset(Global.UI.edgeInset)
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
