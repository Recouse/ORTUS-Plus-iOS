//
//  TranslatableView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Localize_Swift

class TranslatableView: UIView, Translatable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareLocales()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onLanguageChanged),
            name: NSNotification.Name(LCLLanguageChangeNotification),
            object: nil
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onLanguageChanged() {
        languageChanged()
    }
    
    func languageChanged() {
        prepareLocales()
    }
    
    /// Method that can be overridden. Here you should set localizable string to views properties.
    func prepareLocales() {}
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

