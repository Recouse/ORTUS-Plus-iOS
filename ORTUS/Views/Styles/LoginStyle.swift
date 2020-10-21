//
//  LoginStyle.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

enum LoginStyle {
    static let signInButton = Styling<OButton> {
        $0.backgroundColor = .clear
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.withAlphaComponent(0.9).cgColor
        $0.layer.cornerRadius = 6
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16)
    }
}
