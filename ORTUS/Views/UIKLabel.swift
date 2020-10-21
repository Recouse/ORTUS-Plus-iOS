//
//  UIKLabel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 10/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import SwiftUI

struct TextWithAttributedString: UIViewRepresentable {
    fileprivate var configuration = { (view: UILabel) in }

    func makeUIView(context: UIViewRepresentableContext<Self>) -> UILabel {
        UILabel()
    }
    
    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
    }
}
