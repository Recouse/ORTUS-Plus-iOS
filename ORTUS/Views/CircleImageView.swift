//
//  CircleImageView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/9/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        clipsToBounds = true
        layer.cornerRadius = bounds.height / 2
    }
}
