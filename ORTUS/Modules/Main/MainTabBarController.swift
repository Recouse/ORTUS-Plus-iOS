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
    
    // News
    lazy var newsItem: UITabBarItem = {
        var item = UITabBarItem()
        item.tag = Global.UI.TabBar.news.rawValue
        
        DispatchQueue.global(qos: .userInitiated).async {
            let image = UIImage(named: "news")?.forceLoad()
            
            DispatchQueue.main.async {
                item.image = image
            }
        }
        
        return item
    }()
    
    lazy var newsController: NavigationController = { [unowned self] in
        let module = NewsModuleBuilder.build()
        let controller = NavigationController(rootViewController: module)
        controller.tabBarItem = self.newsItem
        
        return controller
    }()
    
    // Schedule
    let scheduleItem: UITabBarItem = {
        let item = UITabBarItem()
        item.tag = Global.UI.TabBar.schedule.rawValue
        
        DispatchQueue.global(qos: .userInitiated).async {
            let image = UIImage(named: "schedule")?.forceLoad()
            
            DispatchQueue.main.async {
                item.image = image
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
    
    // Courses
    let coursesItem: UITabBarItem = {
        let item = UITabBarItem()
        item.tag = Global.UI.TabBar.courses.rawValue
        
        DispatchQueue.global(qos: .userInitiated).async {
            let image = UIImage(named: "courses")?.forceLoad()
            
            DispatchQueue.main.async {
                item.image = image
            }
        }
        
        return item
    }()
    
    lazy var coursesController: NavigationController = { [unowned self] in
        let module = CoursesModuleBuilder.build()
        let controller = NavigationController(rootViewController: module)
        controller.tabBarItem = self.coursesItem
        
        return controller
    }()
    
    // TODO: Inbox
    // Notifications
//    let inboxItem: UITabBarItem = {
//        let item = UITabBarItem()
//        item.tag = Global.UI.TabBar.inbox.rawValue
//        item.badgeValue = "2"
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            let image = UIImage(named: "inbox")?.forceLoad()
//
//            DispatchQueue.main.async {
//                item.image = image
//            }
//        }
//
//        return item
//    }()
//
//    lazy var inboxController: NavigationController = { [unowned self] in
//        let module = InboxModuleBuilder.build()
//        let controller = NavigationController(rootViewController: module)
//        controller.tabBarItem = self.inboxItem
//
//        return controller
//    }()
    
    // Settings
    lazy var settingsItem: UITabBarItem = {
        var item = UITabBarItem()
        item.tag = Global.UI.TabBar.settings.rawValue
        
        DispatchQueue.global(qos: .userInitiated).async {
            let image = UIImage(named: "settings")?.forceLoad()
            
            DispatchQueue.main.async {
                item.image = image
            }
        }
        
        return item
    }()
    
    lazy var settingsController: NavigationController = { [unowned self] in
        let module = SettingsModuleBuilder.build()
        let controller = NavigationController(rootViewController: module)
        controller.tabBarItem = self.settingsItem
        
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(prepareViewControllers),
            name: .authComplete,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(prepareViewControllers),
            name: .userSignedOut,
            object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        prepareViewControllers()
    }
    
    override func prepareLocales() {
        newsItem.title = "news.title".localized()
        scheduleItem.title = "schedule.title".localized()
        coursesItem.title = "courses.title".localized()
        // TODO: Inbox
//        inboxItem.title = "inbox.title".localized()
        settingsItem.title = "settings.title".localized()
    }
    
    @objc func prepareViewControllers() {
        var modules: [UIViewController] = []
        
        modules.append(newsController)
        
        if UserViewModel.isLoggedIn {
            modules.append(scheduleController)
            modules.append(coursesController)
            // TODO: Inbox
//            modules.append(inboxController)
        }
        
        modules.append(settingsController)
        
        viewControllers = modules
        
        if UserViewModel.isLoggedIn, isFirstAppear {
            selectedIndex = 1
            isFirstAppear = false
        }
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if selectedIndex == item.tag {
            NotificationCenter.default.post(name: .scrollToTop, object: nil)
        }
    }
}
