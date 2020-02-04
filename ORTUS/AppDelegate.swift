//
//  AppDelegate.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import YandexMobileMetrica
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let keychain = Keychain()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Clear keychain on a new installation
        clearKeychain()
        
        prepareAnalytics()
        
        if keychain[Global.Key.accessToken] == nil {
            prepareLoginController()
        } else {
            prepareMainTabBarController()
        }
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        OAuth.resolve(url)
        
        return true
    }
    
    private func clearKeychain() {
        if UserDefaults.standard.object(forKey: Global.Key.firstInstall) == nil {
            keychain[Global.Key.accessToken] = nil
            keychain[Global.Key.refreshToken] = nil
            keychain[Global.Key.tokenExpiresOn] = nil
            keychain[Global.Key.ortusPinCode] = nil
            
            UserDefaults.standard.set(false, forKey: Global.Key.firstInstall)
        }
    }
    
    fileprivate func prepareAnalytics() {
        // Yandex App Metrica
        let configuration = YMMYandexMetricaConfiguration(apiKey: Global.yandexAppMetricaKey)
        YMMYandexMetrica.activate(with: configuration!)
    }
    
    fileprivate func prepareMainTabBarController() {
        let tabBarController = MainTabBarController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    fileprivate func prepareLoginController() {
        let loginController = LoginModuleBuilder.build()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = loginController
        window?.makeKeyAndVisible()
    }
}

