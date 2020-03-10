//
//  LectureComponentView.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 09/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class LectureComponentView: UIView {
    let contentSeparator: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .lightGray
        }
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        prepareContentSeparator()
        prepareNameLabel()
        prepareAddressLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LectureComponentView {
    func prepareContentSeparator() {
        addSubview(contentSeparator)
        contentSeparator.snp.makeConstraints {
            $0.width.equalTo(2.5)
            $0.top.bottom.equalToSuperview().offset(5).inset(5)
            $0.left.equalToSuperview().offset(16)
        }
    }
    
    func prepareNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalTo(contentSeparator.snp.right).offset(20)
            $0.right.equalToSuperview().inset(16)
        }
    }
    
    func prepareAddressLabel() {
        addSubview(addressLabel)
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.left.equalTo(contentSeparator.snp.right).offset(20)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(5).priority(250)
        }
    }
}
