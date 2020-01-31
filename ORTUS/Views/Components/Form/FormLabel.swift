//
//  FormLabel.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct FormLabel: IdentifiableComponent {
    var title: String
    var color: UIColor = Asset.Colors.tintColor.color
    var onSelect: () -> Void
    
    var id: String {
        return title
    }
    
    func renderContent() -> FormLabelView {
        return FormLabelView()
    }
    
    func render(in content: FormLabelView) {
        content.label.textColor = color
        content.label.text = title
        content.onSelect = onSelect
    }
    
    func shouldContentUpdate(with next: FormLabel) -> Bool {
        return title != next.title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class FormLabelView: UIControl {
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        
        return label
    }()
    
    var onSelect: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemGroupedBackground
        } else {
            backgroundColor = .white
        }
        
        addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.center.equalToSuperview()
        }
        
        addTarget(self, action: #selector(selected), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selected() {
        onSelect?()
    }
}
