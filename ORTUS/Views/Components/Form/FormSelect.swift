//
//  FormSelect.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/12/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct FormSelect: Component {
    var title: String
    
    var id: String {
        return title
    }
    
    func renderContent() -> FormSelectView {
        return FormSelectView()
    }
    
    func render(in content: FormSelectView) {
        content.titleLabel.text = title
    }
    
    func shouldContentUpdate(with next: FormSection) -> Bool {
        return title != next.title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class FormSelectView: UIView {
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
