//
//  FormLink.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct FormLink: IdentifiableComponent {
    var title: String
    var url: String
    var onSelect: ((_ url: String) -> Void)?
    
    var id: String {
        return title
    }
    
    func renderContent() -> FormLinkView {
        return FormLinkView()
    }
    
    func render(in content: FormLinkView) {
        content.url = url
        content.titleLabel.text = title
        content.onSelect = onSelect
    }
    
    func shouldContentUpdate(with next: FormLink) -> Bool {
        return title != next.title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class FormLinkView: UIControl {
    var url: String = ""
    var onSelect: ((_ url: String) -> Void)?
    
    let titleLabel = UILabel()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.external.image
        imageView.contentMode = .scaleAspectFit
        if #available(iOS 13.0, *) {
            imageView.tintColor = .tertiaryLabel
        } else {
            imageView.tintColor = .gray
        }
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemGroupedBackground
        } else {
            backgroundColor = .white
        }
        
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
        
        addTarget(self, action: #selector(selected), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selected() {
        onSelect?(url)
    }
}
