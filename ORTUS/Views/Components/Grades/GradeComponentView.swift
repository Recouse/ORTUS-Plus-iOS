//
//  GradeComponentView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 05/02/20.
//  Copyright © 2020 Firdavs. All rights reserved.
//

import UIKit

class GradeComponentView: UIView {
    let gradeContainerView: CircleView = {
        let view = CircleView()
        view.backgroundColor = Asset.Colors.tintColor.color
        
        return view
    }()
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        
        return label
    }()
    
    let courseLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        return label
    }()
    
    let creditPointsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    let lecturerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        if #available(iOS 13.0, *) {
            label.textColor = .secondaryLabel
        } else {
            label.textColor = .gray
        }
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if #available(iOS 13.0, *) {
            backgroundColor = .secondarySystemGroupedBackground
        } else {
            backgroundColor = .white
        }
        
        prepareGradeLabel()
        prepareCourseLabel()
        prepareCreditPointsLabel()
        prepareLecturerLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension GradeComponentView {
    func prepareGradeLabel() {
        addSubview(gradeContainerView)
        gradeContainerView.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.top.equalToSuperview().offset(10)
            $0.right.equalToSuperview().inset(Global.UI.edgeInset)
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
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(gradeContainerView.snp.left).offset(-15)
        }
    }
    
    func prepareCreditPointsLabel() {
        addSubview(creditPointsLabel)
        creditPointsLabel.snp.makeConstraints {
            $0.top.equalTo(courseLabel.snp.bottom).offset(5)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(gradeContainerView.snp.left).offset(-15)
        }
    }
    
    func prepareLecturerLabel() {
        addSubview(lecturerLabel)
        lecturerLabel.snp.makeConstraints {
            $0.top.equalTo(creditPointsLabel.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(Global.UI.edgeInset)
            $0.right.equalTo(gradeContainerView.snp.left).offset(-15)
            $0.bottom.equalToSuperview().inset(10).priority(250)
        }
    }
}
