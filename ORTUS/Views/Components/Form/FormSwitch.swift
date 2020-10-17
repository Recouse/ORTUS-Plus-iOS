//
//  FormSwitch.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 06/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct FormSwitch: IdentifiableComponent {
    var title: String
    var isOn: Bool
    var onSwitch: ((Bool) -> Void)?
    
    var id: String {
        return title
    }
    
    func renderContent() -> FormSwitchView {
        return FormSwitchView()
    }
    
    func render(in content: FormSwitchView) {
        content.titleLabel.text = title
        content.switchControl.isOn = isOn
        content.onSwitch = onSwitch
    }
    
    func shouldContentUpdate(with next: FormSwitch) -> Bool {
        return title != next.title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class FormSwitchView: UIControl {
    let titleLabel = UILabel()
    
    let switchControl: UISwitch = {
        let control = UISwitch()
        control.onTintColor = Asset.Colors.tintColor.color
        
        return control
    }()
    
    var onSwitch: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemGroupedBackground
        
        addSubview(titleLabel)
        addSubview(switchControl)
        
        titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.lessThanOrEqualTo(switchControl.snp.left).offset(-15)
            $0.centerY.equalToSuperview()
        }
        
        switchControl.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
        
        switchControl.addTarget(self, action: #selector(switched), for: .valueChanged)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switched() {
        onSwitch?(switchControl.isOn)
    }
}
