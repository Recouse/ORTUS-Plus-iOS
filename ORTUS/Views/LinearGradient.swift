//
//  LinearGradient.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

enum GradientDirection {
    case topToBottom
    case leftToRight
}

class LinearGradient: UIView {
    var direction: GradientDirection
    var fromColor: UIColor
    var toColor: UIColor
    
    var isRounded: Bool
    
    init(_ direction: GradientDirection, fromColor: UIColor, toColor: UIColor, isRounded: Bool = false) {
        self.direction = direction
        self.fromColor = fromColor
        self.toColor = toColor
        self.isRounded = isRounded
        
        super.init(frame: .zero)
        
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let colors = [fromColor.cgColor, toColor.cgColor] as CFArray
        
        var start: CGPoint!
        var end: CGPoint!
        
        switch direction {
        case .topToBottom:
            start = CGPoint(x: frame.midX, y: frame.minY)
            end = CGPoint(x: frame.midX, y: frame.maxY)
        case .leftToRight:
            start = CGPoint(x: frame.minX, y: frame.midY)
            end = CGPoint(x: frame.maxX, y: frame.midY)
        }
        
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        let context = UIGraphicsGetCurrentContext()
        
        context?.drawLinearGradient(gradient!, start: start, end: end, options: .drawsBeforeStartLocation)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isRounded {
            layer.cornerRadius = bounds.height / 2
        }
    }
}
