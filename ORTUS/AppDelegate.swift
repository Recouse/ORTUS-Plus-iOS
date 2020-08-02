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
        prepareOnFirstInstall()
        
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
        
        // Set minimum background fetch interval to 1 hour
        UIApplication.shared.setMinimumBackgroundFetchInterval(60 * 60)
        
        // Return false if app was launched from shortcut
        return shortcutItem == nil
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return processActivity(userActivity)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        OAuth.resolve(url)
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        processShortcut(shortcutItem, controller: window?.rootViewController)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
    
    private func prepareOnFirstInstall() {
        if UserDefaults.standard.value(for: .firstInstall) == nil {
            keychain[Global.Key.accessToken] = nil
            keychain[Global.Key.refreshToken] = nil
            keychain[Global.Key.tokenExpiresOn] = nil
            keychain[Global.Key.ortusPinCode] = nil
            
            UserDefaults(suiteName: Global.Key.appGroup)?.set(true, for: .showEvents)
            UserDefaults.standard.set(false, for: .firstInstall)
        }
    }
    
    private func processActivity(_ userActivity: NSUserActivity) -> Bool {
        guard let mainTabBarController = window?.rootViewController as? MainTabBarController else {
            return false
        }
        
        guard let selectedNavigationController = mainTabBarController.viewControllers?[mainTabBarController.selectedIndex] as? NavigationController else {
            return false
        }
        
        guard let type = userActivity.activityType.split(separator: ".").last else {
            return false
        }
        
        guard let activity = ActivityItem(rawValue: String(type)) else {
            return false
        }
        
        var module: Module
        
        switch activity {
        case .news:
            module = NewsModuleBuilder.build()
        case .grades:
            module = GradesModuleBuilder.build()
        case .contacts:
            module = ContactsModuleBuilder.build()
        case .ortusWebsite:
            module = BrowserModuleBuilder.build(with: Global.ortusURL)
            module.hidesBottomBarWhenPushed = true
        }
        
        // Don't push if user is already on that controller
        if object_getClassName(module) == object_getClassName(selectedNavigationController.topViewController) {
            return false
        }
        
        selectedNavigationController.pushViewController(module, animated: true)
        
        return true
    }
    
    private func processShortcut(_ item: UIApplicationShortcutItem, controller: UIViewController?) {
        guard let mainTabBarController = controller as? MainTabBarController else {
            return
        }
        
        preselectIndex(for: item, on: mainTabBarController)
        
        if item.type == Global.QuickAction.ortusAction {
            guard let selectedNavigationController = mainTabBarController.viewControllers?[mainTabBarController.selectedIndex] as? NavigationController else {
                return
            }
            
            EventLogger.log(.openedOrtusShortcut)
            
            let browserModule = BrowserModuleBuilder.build(with: Global.ortusURL, customTransition: nil)
            browserModule.hidesBottomBarWhenPushed = true
            selectedNavigationController.pushViewController(browserModule, animated: true)
        }
    }
    
    private func preselectIndex(for item: UIApplicationShortcutItem?, on tabBarController: MainTabBarController) {
        switch item?.type {
        case Global.QuickAction.schedule:
            EventLogger.log(.openedScheduleShortcut)
            tabBarController.selectedIndex = Global.UI.TabBar.schedule.rawValue
        case Global.QuickAction.notifications:
            EventLogger.log(.openedNotificationsShortCut)
            tabBarController.selectedIndex = Global.UI.TabBar.notifications.rawValue
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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.tintColor = Asset.Colors.tintColor.color
        window?.makeKeyAndVisible()
        
        preselectIndex(for: item, on: tabBarController)
        
        if item?.type == Global.QuickAction.ortusAction {
            guard let selectedNavigationController = tabBarController.viewControllers?.first as? NavigationController else {
                return
            }
            
            let browserModule = BrowserModuleBuilder.build(with: Global.ortusURL, customTransition: nil)
            browserModule.hidesBottomBarWhenPushed = true
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

