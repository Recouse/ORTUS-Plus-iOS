//
//  EmptyComponentView.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 11/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class EmptyComponentView: UIControl {
    var onSelect: (() -> Void)?
    
    let textLabel: UILabel = {
        let label = UILabel()
        if #available(iOSApplicationExtension 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .lightGray
        }
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.right.equalToSuperview().offset(20).inset(20).priority(250)
        }
        
        addTarget(self, action: #selector(open), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func open() {
        onSelect?()
    }
}
