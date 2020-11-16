//
//  SemesterComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 8/20/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class SemesterComponentView: UIView {
    let coursesCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let textLabel = UILabel()
    
    let contentLayoutGuide = UILayoutGuide()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevronRight")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tertiaryLabel
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(rightAccessoryView)
        rightAccessoryView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
        
        addLayoutGuide(contentLayoutGuide)
        contentLayoutGuide.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(10)
        }
        
        addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.top.equalTo(contentLayoutGuide)
            $0.left.right.equalTo(contentLayoutGuide)
        }
        
        addSubview(coursesCountLabel)
        coursesCountLabel.snp.makeConstraints {
            $0.top.equalTo(textLabel.snp.bottom).offset(2)
            $0.left.right.equalTo(contentLayoutGuide)
            $0.bottom.equalTo(contentLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
