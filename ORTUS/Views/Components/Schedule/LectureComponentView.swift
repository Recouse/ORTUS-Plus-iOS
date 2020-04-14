//
//  LectureComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 12/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class LectureComponentView: UIView {
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = ColorCompatibility.label
        
        return label
    }()
    
    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = ColorCompatibility.secondaryLabel
        
        return label
    }()
    
    let contentSeparator: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = ColorCompatibility.label
        label.numberOfLines = 2
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorCompatibility.systemBackground
        
        prepareTimeLabels()
        prepareContentSeparator()
        prepareNameLabel()
        prepareAddressLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LectureComponentView {
    func prepareTimeLabels() {
        addSubview(startTimeLabel)
        startTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset * 2)
        }
        
        addSubview(endTimeLabel)
        endTimeLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(7)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset * 2)
        }
    }
    
    func prepareContentSeparator() {
        let dateEstimatedWidth = ("00:00" as NSString)
            .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width
        
        addSubview(contentSeparator)
        contentSeparator.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.top.bottom.equalToSuperview().offset(7).inset(7)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset * 2 + dateEstimatedWidth + 7)
        }
    }
    
    func prepareNameLabel() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.left.equalTo(contentSeparator.snp.right).offset(7)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
//            $0.bottom.equalToSuperview().inset(7).priority(250)
        }
    }
    
    func prepareAddressLabel() {
        addSubview(addressLabel)
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
            $0.left.equalTo(contentSeparator.snp.right).offset(7)
            $0.bottom.equalToSuperview().inset(7).priority(250)
        }
    }
}
