//
//  LoginOnboardingContentViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

struct LoginOnboardingContent {
    let image: UIImage
    let title: String
    let description: String
}

class LoginOnboardingContentViewController: Module {
    let content: LoginOnboardingContent
    
    weak var loginOnboardingContentView: LoginOnboardingContentView! { return view as? LoginOnboardingContentView }
    weak var imageView: UIImageView! { return loginOnboardingContentView.imageView }
    weak var titleLabel: UILabel! { return loginOnboardingContentView.titleLabel }
    weak var descriptionLabel: UILabel! { return loginOnboardingContentView.descriptionLabel }
    
    init(content: LoginOnboardingContent) {
        self.content = content
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = LoginOnboardingContentView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = content.image
        titleLabel.text = content.title
        descriptionLabel.text = content.description
    }
}
