//
//  FormButton.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct FormButton: Component {
    var title: String
    var color: UIColor = Asset.Colors.tintColor.color
    
    func renderContent() -> FormLabelView {
        return FormLabelView()
    }
    
    func render(in content: FormLabelView) {
        content.label.textColor = color
        content.label.text = title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class FormLabelView: UIView {
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
