//
//  ArticleSectionHeader.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

struct ArticleSectionHeader: Carbon.Component, Equatable {
    let dateFormatter = LatviaDateFormatter()
    
    var date: Date
    
    func renderContent() -> ArticleSectionHeaderView {
        return ArticleSectionHeaderView()
    }
    
    func render(in content: ArticleSectionHeaderView) {
        dateFormatter.dateFormat = "MMM d, yyyy"
        content.dateLabel.text = dateFormatter.string(from: date)
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return CGSize(width: bounds.width, height: 35)
    }
}

class ArticleSectionHeaderView: UIView {
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
