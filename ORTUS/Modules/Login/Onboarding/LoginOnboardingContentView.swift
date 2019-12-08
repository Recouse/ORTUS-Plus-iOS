//
//  LoginOnboardingContentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class LoginOnboardingContentView: UIView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            self.imageView, self.titleLabel, self.descriptionLabel
        ])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 5
        
        stackView.setCustomSpacing(10, after: self.imageView)
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().priority(250)
            $0.left.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalTo(stackView).multipliedBy(0.7)
            $0.height.equalTo(imageView.snp.width).multipliedBy(0.75)
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
