//
//  GradeComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class GradeComponentView: UIView {
    let gradeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.Colors.tintColor.color
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        return view
    }()
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    let courseLabel = UILabel()
    
    let lecturerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    let rightAccessoryView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chevronRight")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .tertiaryLabel
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        prepareRightAccessory()
        prepareGradeLabel()
        prepareCourseLabel()
        prepareLecturerLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GradeComponentView {
    func prepareRightAccessory() {
        addSubview(rightAccessoryView)
        rightAccessoryView.snp.makeConstraints {
            $0.size.equalTo(18)
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
        }
    }
    
    func prepareGradeLabel() {
        addSubview(gradeContainerView)
        gradeContainerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().offset(10).inset(10)
            $0.width.equalTo(gradeContainerView.snp.height)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
        }
        
        gradeContainerView.addSubview(gradeLabel)
        gradeLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func prepareCourseLabel() {
        addSubview(courseLabel)
        courseLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(gradeContainerView.snp.right).offset(10)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(-10)
        }
    }
    
    func prepareLecturerLabel() {
        addSubview(lecturerLabel)
        lecturerLabel.snp.makeConstraints {
            $0.left.equalTo(gradeContainerView.snp.right).offset(10)
            $0.right.equalTo(rightAccessoryView.snp.left).offset(-10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}
