//
//  MaskLabel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 25/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class MaskLabel: UILabel {
    var insetTop: CGFloat {
        get { return self.textInsets.top }
        set { self.textInsets.top = newValue }
    }
    
    var insetLeft: CGFloat {
        get { return self.textInsets.left }
        set { self.textInsets.left = newValue }
    }
    
    var insetBottom: CGFloat {
        get { return self.textInsets.bottom }
        set { self.textInsets.bottom = newValue }
    }
    
    var insetRight: CGFloat {
        get { return self.textInsets.right }
        set { self.textInsets.right = newValue }
    }
    
    private var textInsets = UIEdgeInsets.zero
    private var originalBackgroundColor: UIColor? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLabelUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.saveGState()
        context.setBlendMode(.clear)
        
        originalBackgroundColor?.setFill()
        UIRectFill(rect)
        
        super.drawText(in: rect)
        context.restoreGState()
    }
    
    private func setLabelUI() {
        // cache (Before masking the label, the background color must be clear. So we have to cache it)
        originalBackgroundColor = backgroundColor
        backgroundColor = .clear
    }
}
