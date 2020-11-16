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
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .label
        
        return label
    }()
    
    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let dateEstimatedWidth = ("99:99" as NSString)
        .size(withAttributes: [.font: UIFont.preferredFont(forTextStyle: .callout)]).width
    
    let colorBarView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(for: .headline, weight: .medium)
        label.textColor = .label
        label.numberOfLines = 2
        
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        addSubview(colorBarView)
        addSubview(nameLabel)
        addSubview(addressLabel)
        addSubview(startTimeLabel)
        addSubview(endTimeLabel)
        
        colorBarView.snp.makeConstraints {
            $0.width.equalTo(4)
            $0.top.equalTo(nameLabel)
            $0.bottom.equalTo(addressLabel)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(colorBarView.snp.right).offset(6)
            $0.right.equalTo(startTimeLabel.snp.left).offset(-5)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(5)
            $0.left.equalTo(colorBarView.snp.right).offset(6)
            $0.right.equalTo(startTimeLabel.snp.left).offset(-5)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        startTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
            $0.width.equalTo(dateEstimatedWidth)
        }
        
        endTimeLabel.snp.makeConstraints {
            $0.top.equalTo(startTimeLabel.snp.bottom).offset(5)
            $0.bottom.equalTo(addressLabel).priority(250)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
            $0.width.equalTo(dateEstimatedWidth)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
