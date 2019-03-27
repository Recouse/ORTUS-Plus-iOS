//
//  AppDelegate.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Localize_Swift
import YandexMobileMetrica

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        prepareAnalytics()
        prepareMainTabBarController()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        OAuth.resolve(url)
        
        return true
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
}

