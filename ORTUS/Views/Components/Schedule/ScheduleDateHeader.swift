//
//  ScheduleDateHeader.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 23/11/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct ScheduleDateHeader: Carbon.Component, Equatable {
    var title: String
    
    let dateFormatter = DateFormatter()
    
    func renderContent() -> ScheduleDateHeaderView {
        return ScheduleDateHeaderView()
    }
    
    func render(in content: ScheduleDateHeaderView) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: title) else {
            content.dayLabel.text = title
            return
        }
        dateFormatter.dateFormat = "EEEE"
        content.dayLabel.text = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "dd.MM"
        content.dayMonthLabel.text = dateFormatter.string(from: date)
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 40)
    }
}

class ScheduleDateHeaderView: UIView {
    let dayLabel: UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.textColor = .label
        } else {
            label.textColor = .black
        }
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    let dayMonthLabel: UILabel = {
        let label = UILabel()
        if #available(iOS 13.0, *) {
            label.textColor = .systemGray
        } else {
            label.textColor = .gray
        }
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemBackground
        } else {
            backgroundColor = .groupTableViewBackground
        }
        
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview()
        }
        
        addSubview(dayMonthLabel)
        dayMonthLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(dayLabel.snp.right).offset(5)
            $0.right.equalToSuperview().inset(5).priority(250)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
