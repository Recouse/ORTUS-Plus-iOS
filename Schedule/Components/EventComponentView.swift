//
//  EventComponentView.swift
//  Schedule
//
//  Created by Firdavs Khaydarov on 09/03/2020.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class EventComponentView: UIView {
    let contentSeparator: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
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
        
        addSubview(contentSeparator)
        addSubview(titleLabel)
        addSubview(timeLabel)
        
        prepareContentSeparator()
        prepareTitleLabel()
        prepareTimeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventComponentView {
    func prepareContentSeparator() {
        contentSeparator.snp.makeConstraints {
            $0.width.equalTo(2.5)
            $0.height.greaterThanOrEqualTo(30)
            $0.top.equalTo(titleLabel)
            $0.bottom.equalTo(timeLabel)
            $0.left.equalToSuperview().offset(16)
        }
    }
    
    func prepareTitleLabel() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.left.equalTo(contentSeparator.snp.right).offset(20)
            $0.right.equalToSuperview().inset(16)
            
        }
    }
    
    func prepareTimeLabel() {
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(contentSeparator.snp.right).offset(20)
            $0.right.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(5).priority(250)
        }
    }
}
