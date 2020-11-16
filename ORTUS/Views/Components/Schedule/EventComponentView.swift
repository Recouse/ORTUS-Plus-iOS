//
//  EventComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 11/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class EventComponentView: UIView {
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textAlignment = .right
        label.textColor = .label
        
        return label
    }()
    
    let dateEstimatedWidth = ("all-day" as NSString)
        .size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .callout)]).width
    
    let colorBarView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .headline, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(colorBarView)
        addSubview(timeLabel)
        addSubview(titleLabel)
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
            $0.width.equalTo(dateEstimatedWidth)
        }
        
        colorBarView.snp.makeConstraints {
            $0.width.equalTo(4)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(titleLabel)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(colorBarView.snp.right).offset(6)
            $0.right.equalTo(timeLabel.snp.left).offset(-5)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
