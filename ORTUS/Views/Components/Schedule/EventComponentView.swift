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
        label.font = .systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.textAlignment = .right
        label.textColor = .label
        
        return label
    }()
    
    let dateEstimatedWidth = ("00:00" as NSString)
        .size(withAttributes: [.font: UIFont.systemFont(ofSize: 14)]).width
    
    let contentSeparator: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemOrange
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 2
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        prepareTimeLabel()
        prepareContentSeparator()
        prepareTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EventComponentView {
    func prepareTimeLabel() {
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset * 2)
            $0.width.equalTo(dateEstimatedWidth)
        }
    }
    
    func prepareContentSeparator() {
        addSubview(contentSeparator)
        contentSeparator.snp.makeConstraints {
            $0.width.equalTo(2)
            $0.height.greaterThanOrEqualTo(30)
            $0.top.bottom.equalToSuperview().offset(7).inset(7)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset * 2 + dateEstimatedWidth + 7)
        }
    }
    
    func prepareTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(7)
            $0.left.equalTo(contentSeparator.snp.right).offset(7)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(7).priority(250)
        }
    }
}
