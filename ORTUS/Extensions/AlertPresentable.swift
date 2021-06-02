//
//  AlertPresentable.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 22/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

enum AlertType: String {
    case info
    case success
    case error
    case warning
}

protocol AlertPresentable: AnyObject {
    func alert(type: AlertType, message: String?, onOk: ((UIAlertAction) -> Void)?)
    func prompt(title: String?, message: String?, onOk: ((UIAlertAction) -> Void)?,
                onCancel: ((UIAlertAction) -> Void)?)
    func confirm(title: String?, message: String?, okTitle: String,
                 onOk: ((UIAlertAction) -> Void)?, onCancel: ((UIAlertAction) -> Void)?)
}

extension AlertPresentable where Self: UIViewController {
    func alert(type: AlertType = .error, message: String?, onOk: ((UIAlertAction) -> Void)? = nil) {
        var typeString: String
        switch type {
        case .info:
            typeString = L10n.info
        case .success:
            typeString = L10n.success
        case .error:
            typeString = L10n.error
        case .warning:
            typeString = L10n.warning
        }
        
        let alert = UIAlertController(title: typeString, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.ok, style: .default, handler: onOk))
        
        present(alert, animated: true, completion: nil)
    }
    
    func prompt(title: String?, message: String?, onOk: ((UIAlertAction) -> Void)? = nil,
                onCancel: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.cancel, style: .cancel, handler: onCancel))
        alert.addAction(UIAlertAction(title: L10n.ok, style: .default, handler: onOk))
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func confirm(title: String?, message: String?, okTitle: String,
                 onOk: ((UIAlertAction) -> Void)? = nil, onCancel: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.ok, style: .cancel, handler: onCancel))
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: onOk))
        
        present(alert, animated: true, completion: nil)
    }
}
