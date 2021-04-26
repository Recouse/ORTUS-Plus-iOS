//
//  AppDelegate.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import KeychainAccess

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let keychain = Keychain()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Clear keychain on a new installation
        prepareOnFirstInstall()
                
        // If launchOptions contains the appropriate launch options key, a Home screen quick action
        // is responsible for launching the app. Store the action for processing once the app has
        // completed initialization.
        let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem
        
        if keychain[Global.Key.accessToken] == nil {
            prepareLoginController()
        } else {
            prepareMainTabBarController(with: shortcutItem)
        }
        
        // Appearance
        overrideAppearance()
        
        // Return false if app was launched from shortcut
        return shortcutItem == nil
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        return processActivity(userActivity)
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if url.host == "open" {
            return processOpenURL(url)
        }
        
        OAuth.resolve(url)
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        processShortcut(shortcutItem, controller: window?.rootViewController)
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
        case .course:
            guard let courseURL = userActivity.userInfo?["url"] as? String else {
                return false
            }
            
            module = BrowserModuleBuilder.build(with: courseURL)
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
                        
            let browserModule = BrowserModuleBuilder.build(with: Global.ortusURL, customTransition: nil)
            browserModule.hidesBottomBarWhenPushed = true
            selectedNavigationController.pushViewController(browserModule, animated: true)
        }
    }
    
    private func processOpenURL(_ url: URL) -> Bool {
        guard let mainTabBarController = window?.rootViewController as? MainTabBarController else {
            return false
        }
        
        guard let urlComponents = URLComponents(string: url.absoluteString) else {
            return false
        }
        
        guard let module = urlComponents.queryItems?.first(where: {
            $0.name == "module"
        })?.value else {
            return false
        }
        
        switch Global.Module(rawValue: module) {
        case .schedule:
            mainTabBarController.selectedIndex = Global.UI.TabBar.schedule.rawValue
        default:
            return false
        }
        
        return true
    }
    
    private func preselectIndex(for item: UIApplicationShortcutItem?, on tabBarController: MainTabBarController) {
        switch item?.type {
        case Global.QuickAction.schedule:
            tabBarController.selectedIndex = Global.UI.TabBar.schedule.rawValue
        case Global.QuickAction.notifications:
            tabBarController.selectedIndex = Global.UI.TabBar.notifications.rawValue
        default:
            break
        }
    }
    
    fileprivate func overrideAppearance() {
        let appearance = UserDefaults.standard.value(for: .appearance)
        
        switch appearance {
        case "system":
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
        case "light":
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .light
        case "dark":
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .dark
        default:
            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
        }
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

