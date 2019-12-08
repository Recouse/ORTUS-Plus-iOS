//
//  LoginView.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 07/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit

class LoginView: UIView {
    let backgrounView = LinearGradient(
        .topToBottom,
        fromColor: Asset.Colors.tradewind.color,
        toColor: Asset.Colors.oracle.color
    )
    
    let rtuLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.Images.rtuLogo.image
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let onboardingView = UIView()
    
    var onboardingContentView = UIView() {
        didSet {
            updateOnboardingView()
        }
    }
    
    let signInButton = Button(style: LoginStyle.signInButton)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        prepareBackgroundView()
        prepareRtuLogoView()
        prepareSignInButton()
        prepareOnboardingView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateOnboardingView() {
        onboardingContentView.removeFromSuperview()
        
        onboardingView.addSubview(onboardingContentView)
        onboardingContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension LoginView {
    func prepareBackgroundView() {
        addSubview(backgrounView)
        backgrounView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func prepareRtuLogoView() {
        addSubview(rtuLogoView)
        rtuLogoView.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.top.equalTo(safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
    func prepareSignInButton() {
        addSubview(signInButton)
        signInButton.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(Global.UI.edgeInset)
        }
    }
    
    func prepareOnboardingView() {
        addSubview(onboardingView)
        onboardingView.snp.makeConstraints {
            $0.top.equalTo(rtuLogoView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(signInButton.snp.top).offset(-20)
        }
    }
}
