//
//  LoginOnboardingViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 08/12/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import Pageboy

class LoginOnboardingViewController: PageboyViewController {
    var pageControl: UIPageControl!
    
    let viewControllers: [UIViewController] = [
        LoginOnboardingContentViewController(content: LoginOnboardingContent(
            image: Asset.Images.onboardingSchedule.image,
            title: "Class Schedule",
            description: "Explore your schedule without entering a password every time")),
        LoginOnboardingContentViewController(content: LoginOnboardingContent(
            image: Asset.Images.onboardingCourses.image,
            title: "Courses, Grades, Notifications",
            description: "All needed data in one app")),
        LoginOnboardingContentViewController(content: LoginOnboardingContent(
            image: Asset.Images.onboardingNews.image,
            title: "Recent News",
            description: "Read most recent RTU news"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        
        isInfiniteScrollEnabled = true
        
        preparePageControl()
        
        autoScroller.enable(withIntermissionDuration: .custom(duration: 5))
    }
}

extension LoginOnboardingViewController {
    func preparePageControl() {
        pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.5)
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewControllers.count
        
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
}

extension LoginOnboardingViewController: PageboyViewControllerDataSource, PageboyViewControllerDelegate {
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return .first
    }
    
    func pageboyViewController(_ pageboyViewController: Pageboy.PageboyViewController, willScrollToPageAt index: Pageboy.PageboyViewController.PageIndex, direction: Pageboy.PageboyViewController.NavigationDirection, animated: Bool) {}
    
    func pageboyViewController(_ pageboyViewController: Pageboy.PageboyViewController, didScrollTo position: CGPoint, direction: Pageboy.PageboyViewController.NavigationDirection, animated: Bool) {}
    
    func pageboyViewController(_ pageboyViewController: Pageboy.PageboyViewController, didCancelScrollToPageAt index: Pageboy.PageboyViewController.PageIndex, returnToPageAt previousIndex: Pageboy.PageboyViewController.PageIndex) {}
    
    func pageboyViewController(_ pageboyViewController: Pageboy.PageboyViewController, didScrollToPageAt index: Pageboy.PageboyViewController.PageIndex, direction: Pageboy.PageboyViewController.NavigationDirection, animated: Bool) {
        pageControl.currentPage = index
    }
    
    func pageboyViewController(_ pageboyViewController: Pageboy.PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: Pageboy.PageboyViewController.PageIndex) {}
}
