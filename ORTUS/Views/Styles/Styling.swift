//
//  Style.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

/// Represents view style with a closure that configures the view.
public struct Styling<View: UIView> {
    public let style: (View) -> Void
    
    public init(style: @escaping (View) -> Void) {
        self.style = style
    }
    
    /// Applies self to the view.
    public func apply(to view: View) {
        style(view)
    }
    
    /// Style that does nothing (keeps the default/native style).
    public static var native: Styling<View> {
        return Styling { _ in }
    }
}

extension UIView {
    /// For example: `let nameLabel = UILabel(style: Stylesheet.Profile.name)`.
    public convenience init<V>(style: Styling<V>) {
        self.init(frame: .zero)
        apply(style)
    }
    
    /// Applies the given style to self.
    public func apply<V>(_ style: Styling<V>) {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return
        }
        style.apply(to: view)
    }
    
    /// Returns self with the style applied. For example: `let nameLabel = UILabel().styled(with: Stylesheet.Profile.name)`.
    public func styled<V>(with style: Styling<V>) -> Self {
        guard let view = self as? V else {
            print("💥 Could not apply style for \(V.self) to \(type(of: self))")
            return self
        }
        style.apply(to: view)
        return self
    }
}

extension Styling {
    /// Marges two styles together.
    public func adding<V>(_ other: Styling<V>) -> Styling {
        return Styling {
            self.apply(to: $0)
            other.apply(to: $0 as! V)
        }
    }
    
    /// Returns current style modified by the given closure.
    public func modifying(_ other: @escaping (View) -> Void) -> Styling {
        return Styling {
            self.apply(to: $0)
            other($0)
        }
    }
}
