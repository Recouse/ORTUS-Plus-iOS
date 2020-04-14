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
    
    let dateFormatter = LatviaDateFormatter()
    
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
        label.textColor = ColorCompatibility.label
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    let dayMonthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = ColorCompatibility.systemGray5
        
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
