//
//  CourseView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import WebKit

class CourseView: UIView {
    let loadingOverview: UIView = {
        let view = UIView()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        view.isHidden = true
        
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            view = UIActivityIndicatorView(style: .large)
        } else {
            view = UIActivityIndicatorView(style: .gray)
        }
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(loadingOverview)
        loadingOverview.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        loadingOverview.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
