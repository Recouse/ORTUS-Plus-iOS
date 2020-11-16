//
//  FormLink.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct FormLink: Component {
    var title: String

    func renderContent() -> FormLinkView {
        return FormLinkView()
    }
    
    func render(in content: FormLinkView) {
        content.titleLabel.text = title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class FormLinkView: UIView {
    let titleLabel = UILabel()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.external.image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tertiaryLabel
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(rightAccessoryView)
        rightAccessoryView.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
