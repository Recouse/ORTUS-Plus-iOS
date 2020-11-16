//
//  CircleButton.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/12/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class CircleButton: OButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }
}
