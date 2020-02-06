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
        
        // If launchOptions contains the appropriate launch options key, a Home screen quick action
        // is responsible for launching the app. Store the action for processing once the app has
        // completed initialization.
        let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem
        
        if keychain[Global.Key.accessToken] == nil {
            prepareLoginController()
        } else {
            prepareMainTabBarController(with: shortcutItem)
        }
        
        // Return false if app was launched from shortcut
        return shortcutItem == nil
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        OAuth.resolve(url)
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        processShortcut(shortcutItem)
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
    
    private func processShortcut(_ item: UIApplicationShortcutItem) {
        guard let mainTabBarController = window?.rootViewController as? MainTabBarController else {
            return
        }
        
        switch item.type {
        case Global.QuickAction.ortusAction:
            guard let selectedNavigationController = mainTabBarController.viewControllers?[mainTabBarController.selectedIndex] as? NavigationController else {
                break
            }
            
            let browserModule = BrowserModuleBuilder.build(with: Global.ortusURL, customTransition: nil)
            selectedNavigationController.pushViewController(browserModule, animated: true)
        case Global.QuickAction.schedule:
            mainTabBarController.selectedIndex = Global.UI.TabBar.schedule.rawValue
        case Global.QuickAction.notifications:
            mainTabBarController.selectedIndex = Global.UI.TabBar.notifications.rawValue
        default:
            break
        }
    }
    
    fileprivate func prepareAnalytics() {
        // Yandex App Metrica
        let configuration = YMMYandexMetricaConfiguration(apiKey: Global.yandexAppMetricaKey)
        YMMYandexMetrica.activate(with: configuration!)
    }
    
    fileprivate func prepareMainTabBarController(with item: UIApplicationShortcutItem?) {
        let tabBarController = MainTabBarController()
        
        switch item?.type {
        case Global.QuickAction.schedule:
            tabBarController.selectedIndex = Global.UI.TabBar.schedule.rawValue
        case Global.QuickAction.notifications:
            tabBarController.selectedIndex = Global.UI.TabBar.notifications.rawValue
        default:
            break
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        if item?.type == Global.QuickAction.ortusAction {
            guard let selectedNavigationController = tabBarController.viewControllers?.first as? NavigationController else {
                return
            }
            
            let browserModule = BrowserModuleBuilder.build(with: Global.ortusURL, customTransition: nil)
            selectedNavigationController.pushViewController(browserModule, animated: false)
        }
    }
    
    fileprivate func prepareLoginController() {
        let loginController = LoginModuleBuilder.build()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = loginController
        window?.makeKeyAndVisible()
    }
}

