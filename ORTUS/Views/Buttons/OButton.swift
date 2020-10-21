//
//  Button.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class OButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            let alpha: CGFloat = isHighlighted ? 0.65 : 1
            animate(alpha)
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            updateEnabledState()
        }
    }
    
    var _tintColor: UIColor? {
        didSet {
            tintColor = _tintColor
        }
    }
    
    var disabledTintColor: UIColor?
    
    var _backgroundColor: UIColor? {
        didSet {
            backgroundColor = _backgroundColor
        }
    }
    
    var disabledBackgroundColor: UIColor?
    
    func setImage(_ image: UIImage?) {
        setImage(image, for: .application)
        setImage(image, for: .disabled)
        setImage(image, for: .focused)
        setImage(image, for: .highlighted)
        setImage(image, for: .normal)
        setImage(image, for: .reserved)
        setImage(image, for: .selected)
    }
    
    private func animate(_ alpha: CGFloat) {
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 3,
            options: [.curveEaseInOut],
            animations: {
                self.alpha = alpha
        }
        )
    }
    
    func setTintColor(_ color: UIColor?) {
        _tintColor = color
    }
    
    func setBackgroundColor(_ color: UIColor?) {
        _backgroundColor = color
    }
    
    func updateEnabledState() {
        if isEnabled {
            tintColor = _tintColor
            backgroundColor = _backgroundColor
        } else {
            if let disabledTintColor = disabledTintColor {
                tintColor = disabledTintColor
            }
            
            if let disabledBackgroundColor = disabledBackgroundColor {
                backgroundColor = disabledBackgroundColor
            }
        }
    }
}

