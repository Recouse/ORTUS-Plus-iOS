//
//  MainTabBarController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit

class MainTabBarController: TabBarController {
    var isFirstAppear: Bool = true
    
    // Home
    lazy var homeItem: UITabBarItem = {
        var item = UITabBarItem()
        item.tag = Global.UI.TabBar.home.rawValue
        item.image = UIImage(systemName: "house")
        
        return item
    }()
    
    lazy var homeController: NavigationController = { [unowned self] in
        let module = HomeModuleBuilder.build()
        let controller = NavigationController(rootViewController: module)
        controller.tabBarItem = self.homeItem
        
        return controller
    }()
    
    // Schedule
    let scheduleItem: UITabBarItem = {
        let item = UITabBarItem()
        item.tag = Global.UI.TabBar.schedule.rawValue
        item.image = UIImage(systemName: "calendar")
        
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
        item.image = UIImage(systemName: "bell")
        item.selectedImage = UIImage(systemName: "bell.fill")

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
        
        updateNotificationsItem()
        prepareData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareViewControllers()
    }
    
    func prepareData() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateNotificationsItem),
            name: .updatedNotificationsCount,
            object: nil
        )
        
        homeItem.title = L10n.Home.title
        scheduleItem.title = L10n.Schedule.title
        notificationsItem.title = L10n.Notifications.title
    }
    
    func prepareViewControllers() {
        viewControllers = [
            homeController,
            scheduleController,
            notificationsController
        ]
    }
    
    @objc func updateNotificationsItem() {
        guard let notificationsCount = UserDefaults.standard.value(for: .notificationsCount),
            notificationsCount > 0 else {
            notificationsItem.badgeValue = nil
            UIApplication.shared.applicationIconBadgeNumber = 0
            
            return
        }
        
        notificationsItem.badgeValue = "\(notificationsCount)"
        UIApplication.shared.applicationIconBadgeNumber = notificationsCount
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if selectedIndex == item.tag {
            NotificationCenter.default.post(name: .scrollToTop, object: nil)
        }
    }
}
