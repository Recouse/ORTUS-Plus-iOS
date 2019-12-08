//
//  LoginView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 07/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class LoginView: UIView {
    let backgrounView = LinearGradient(
        .topToBottom,
        fromColor: Asset.Colors.tradewind.color,
        toColor: Asset.Colors.oracle.color
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgrounView)
        backgrounView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
