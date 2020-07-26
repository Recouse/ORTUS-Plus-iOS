//
//  StateComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 7/12/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct StateComponent: Component {
    let image: UIImage?
    let primaryText: String
    let secondaryText: String?
    let height: CGFloat
    
    func renderContent() -> StateComponentView {
        return StateComponentView()
    }
    
    func render(in content: StateComponentView) {
        content.imageView.isHidden = image == nil
        content.imageView.image = image
        
        content.primaryLabel.text = primaryText
        
        content.secondaryLabel.isHidden = secondaryText == nil
        content.secondaryLabel.text = secondaryText
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: height)
    }
}

class StateComponentView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        
        return imageView
    }()
    
    let primaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.textColor = ColorCompatibility.secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.imageView, self.primaryLabel, self.secondaryLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        
        stackView.setCustomSpacing(15, after: self.imageView)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
        
        imageView.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(150)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
