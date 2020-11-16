//
//  ButtonsStyle.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 4/12/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

enum ButtonsStyle {
    static let action = Styling<OButton> {
        $0.setBackgroundColor(Asset.Colors.tintColor.color)
        $0.disabledBackgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
        $0.setTintColor(.white)
        $0.disabledTintColor = .lightGray
    }
}
