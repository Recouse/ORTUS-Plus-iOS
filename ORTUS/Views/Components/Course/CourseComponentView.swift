//
//  CourseComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 02/10/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class CourseComponentView: UIView {
    let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 2
        
        return label
    }()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.chevronRight.image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareImageContainerView()
        prepareRightAccessoryView()
        prepareTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CourseComponentView {
    func prepareImageContainerView() {
        addSubview(imageContainerView)
        imageContainerView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.size.equalTo(imageContainerView).multipliedBy(0.5)
            $0.center.equalTo(imageContainerView)
        }
    }
    
    func prepareRightAccessoryView() {
        addSubview(rightAccessoryView)
        rightAccessoryView.snp.makeConstraints {
            $0.size.equalTo(14)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    func prepareTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(imageContainerView.snp.right).offset(15)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(-10)
            $0.bottom.equalToSuperview().inset(10).priority(250)
        }
    }
}
