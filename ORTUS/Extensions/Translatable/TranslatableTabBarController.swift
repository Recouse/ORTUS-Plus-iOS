//
//  TranslatableTabBarController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Localize_Swift

class TranslatableTabBarController: TabBarController, Translatable {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareLocales()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onLanguageChanged),
            name: NSNotification.Name(LCLLanguageChangeNotification),
            object: nil
        )
    }
    
    @objc private func onLanguageChanged() {
        languageChanged()
    }
    
    func languageChanged() {
        prepareLocales()
    }
    
    /// Method that can be overridden. Here you should set localizable string to views properties.
    func prepareLocales() {}
}
