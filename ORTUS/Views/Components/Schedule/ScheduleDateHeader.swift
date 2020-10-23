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
        dateFormatter.dateFormat = "EEEE, dd.MM"
        content.dayLabel.text = dateFormatter.string(from: date).uppercased()
        
        if Calendar.current.dateComponents([.year, .month, .day], from: Date()) == Calendar.current.dateComponents([.year, .month, .day], from: date) {
            content.dayLabel.textColor = .systemRed
        } else {
            content.dayLabel.textColor = .label
        }
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 40)
    }
}

class ScheduleDateHeaderView: UIView {
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.preferredFont(for: .footnote, weight: .semibold)
        
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(5)
        }
        
        addSubview(separatorView)
        separatorView.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
