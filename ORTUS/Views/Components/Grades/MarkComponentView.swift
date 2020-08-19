//
//  MarkComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/19/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class MarkComponentView: UIView {
    let gradeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.tintColor.color
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        return view
    }()
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 34, weight: .medium)
        label.textColor = .white
        
        return label
    }()
        
    let courseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(courseLabel)
        addSubview(gradeContainerView)
        gradeContainerView.addSubview(gradeLabel)
        
        courseLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(gradeContainerView.snp.left).offset(-15)
            $0.bottom.equalToSuperview().inset(15).priority(250)
        }
        
        gradeContainerView.snp.makeConstraints {
            $0.size.equalTo(70)
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview().offset(15).inset(15).priority(500)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
        
        gradeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
