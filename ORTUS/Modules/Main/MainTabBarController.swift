//
//  MainTabBarController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class MainTabBarController: TranslatableTabBarController {
    var isFirstAppear: Bool = true
    
    // Home
    lazy var homeItem: UITabBarItem = {
        var item = UITabBarItem()
        item.tag = Global.UI.TabBar.home.rawValue
        
        if #available(iOS 13.0, *) {
            item.image = UIImage(systemName: "house")
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let image = Asset.Images.home.image.forceLoad()
                let selectedImage = Asset.Images.homeSelected.image.forceLoad()
                
                DispatchQueue.main.async {
                    item.image = image
                    item.selectedImage = selectedImage
                }
            }
        }
        
        return item
    }()
    
    lazy var homeController: NavigationController = { [unowned self] in
        let module = NewsModuleBuilder.build()
        let controller = NavigationController(rootViewController: module)
        controller.tabBarItem = self.homeItem
        
        return controller
    }()
    
    // Schedule
    let scheduleItem: UITabBarItem = {
        let item = UITabBarItem()
        item.tag = Global.UI.TabBar.schedule.rawValue
        
        if #available(iOS 13.0, *) {
            item.image = UIImage(systemName: "calendar")
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let image = Asset.Images.schedule.image.forceLoad()
                
                DispatchQueue.main.async {
                    item.image = image
                }
            }
        }
        
        return item
    }()
    
    lazy var scheduleController: NavigationController = { [unowned self] in
        let module = ScheduleModuleBuilder.build()
        let controller = NavigationController(rootViewController: module)
        controller.tabBarItem = self.scheduleItem
        
        return controller
    }()
    
    // Notifications
    let notificationsItem: UITabBarItem = {
        let item = UITabBarItem()
        item.tag = Global.UI.TabBar.notifications.rawValue

        if #available(iOS 13.0, *) {
            item.image = UIImage(systemName: "bell")
            item.selectedImage = UIImage(systemName: "bell.fill")
        } else {
            DispatchQueue.global(qos: .userInitiated).async {
                let image = Asset.Images.notifications.image.forceLoad()
                let selectedImage = Asset.Images.notificationsSelected.image.forceLoad()
                
                DispatchQueue.main.async {
                    item.image = image
                    item.selectedImage = selectedImage
                }
            }
        }

        return item
    }()

    lazy var notificationsController: NavigationController = { [unowned self] in
        let module = NotificationsModuleBuilder.build()
        let controller = NavigationController(rootViewController: module)
        controller.tabBarItem = self.notificationsItem

        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateNotificationsItem(_:)),
            name: .updatedNotificationsCount,
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareViewControllers()
    }
    
    override func prepareLocales() {
        homeItem.title = "home.title".localized()
        scheduleItem.title = "schedule.title".localized()
        notificationsItem.title = "notifications.title".localized()
    }
    
    func prepareViewControllers() {
        viewControllers = [
            homeController,
            scheduleController,
            notificationsController
        ]
    }
    
    @objc func updateNotificationsItem(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: Int] else {
            return
        }
        
        if let notificationsCount = userInfo["count"], notificationsCount > 0 {
            notificationsItem.badgeValue = "\(notificationsCount)"
            UIApplication.shared.applicationIconBadgeNumber = notificationsCount
            
            return
        }
        
        notificationsItem.badgeValue = nil
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if selectedIndex == item.tag {
            NotificationCenter.default.post(name: .scrollToTop, object: nil)
        }
    }
}
