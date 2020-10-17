//
//  FormTextField.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 31/01/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct FormTextField: IdentifiableComponent {
    var title: String
    var text: String?
    var isSecureTextEntry: Bool = false
    var keyboardType: UIKeyboardType = .default
    var onInput: ((String?) -> Void)?
    
    var id: String {
        return title
    }
    
    func renderContent() -> FormTextFieldView {
        return FormTextFieldView()
    }
    
    func render(in content: FormTextFieldView) {
        content.titleLabel.text = title
        content.textField.text = text
        content.textField.isSecureTextEntry = isSecureTextEntry
        content.textField.keyboardType = keyboardType
        content.onInput = onInput
    }
    
    func shouldContentUpdate(with next: FormTextField) -> Bool {
        return title != next.title
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 44)
    }
}

class FormTextFieldView: UIControl {
    let titleLabel = UILabel()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        
        return textField
    }()
    
    var onInput: ((String?) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemGroupedBackground
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.width.equalTo(80)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(textField)
        textField.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.equalTo(titleLabel.snp.right).offset(Global.UI.edgeInset)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
        
        addTarget(self, action: #selector(selected), for: .touchUpInside)
        textField.addTarget(self, action: #selector(input), for: .allEditingEvents)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selected() {
        textField.becomeFirstResponder()
    }
    
    @objc func input() {
        onInput?(textField.text)
    }
}
