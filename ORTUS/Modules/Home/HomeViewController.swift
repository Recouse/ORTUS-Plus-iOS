//
//  HomeViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 04/02/20.
//  Copyright (c) 2020 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import Promises
import Models

class HomeViewController: ORTUSTableViewController, ModuleViewModel {
    enum ID {
        case news, grades, contacts, ortus
    }
    
    var viewModel: HomeViewModel
    
    var previewingSemesterIndex: Int?
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        suggestPinCodeSetting()
    }
    
    override func prepareData() {
        super.prepareData()
        
        renderer.updater.animatableChangeCount = 0
        
        renderer.adapter.didSelect = { [unowned self] context in
            if let id = context.node.id as? ID {
                switch id {
                case .news:
                    self.viewModel.router.openNews()
                case .grades:
                    self.viewModel.router.openGrades()
                case .contacts:
                    self.viewModel.router.openContacts()
                case .ortus:                    
                    self.viewModel.router.openBrowser(Global.ortusURL)
                }
            } else if let index = context.node.id as? Int {
                self.viewModel.router.openSemester(self.viewModel.semesters[index])
            }
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(scrollToTop),
            name: .scrollToTop,
            object: nil
        )
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        renderer.render {
            Section(id: "overview", header: Header(title: "Overview".uppercased()), cells: {
                IconTextComponent(
                    title: "News",
                    icon: Asset.Images.news.image,
                    color: .systemPurple
                ).identified(by: ID.news)
                
                IconTextComponent(
                    title: "Grades",
                    icon: Asset.Images.ten.image,
                    color: .systemBlue
                ).identified(by: ID.grades)
                
                IconTextComponent(
                    title: "Contacts",
                    icon: UIImage(named: "personCircle"),
                    color: .systemOrange
                ).identified(by: ID.contacts)
                
                IconTextComponent(
                    title: "ORTUS Website",
                    icon: Asset.Images.ortusLogo.image,
                    color: .systemGreen
                ).identified(by: ID.ortus)
            })
            
            Section(id: "courses", header: Header(title: "Courses".uppercased()), cells: {
                Group(of: viewModel.semesters.enumerated()) { (index, semester) in
                    SemesterComponent(
                        semester: semester
                    ).identified(by: index)
                }
            })
        }
    }
    
    func loadData(forceUpdate: Bool = false) {
        if forceUpdate {
            viewModel.loadCourses().always {
                self.render()
            }
            
            return
        }
        
        viewModel.loadCachedCourses().then { _ -> Promise<Bool> in
            self.render()
            
            return self.viewModel.loadCourses()
        }.then { _ in
            self.render()
        }
    }
    
    override func refresh() {
        loadData()
    }
    
    @available(iOS 13.0, *)
    override func contextMenuConfiguration(forRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard indexPath.section == 1 else {
            return nil
        }
        
        previewingSemesterIndex = indexPath.row
        
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: { [unowned self] in
                SemesterModuleBuilder.build(with: self.viewModel.semesters[indexPath.row])
            },
            actionProvider: nil
        )
    }
    
    @available(iOS 13.0, *)
    override func willPerformPreviewActionForMenu(configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        animator.addCompletion {
            guard let previewingSemesterIndex = self.previewingSemesterIndex else {
                return
            }
            
            self.previewingSemesterIndex = nil
            
            self.viewModel.router.openSemester(self.viewModel.semesters[previewingSemesterIndex])
        }
    }
    
    @objc func scrollToTop() {
        guard let tabBarController = navigationController?.tabBarController,
            tabBarController.selectedIndex == Global.UI.TabBar.home.rawValue,
            !tableView.visibleCells.isEmpty else {
            return
        }
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func openSettings() {
        viewModel.router.openSettings()
    }
    
    func suggestPinCodeSetting() {
        let pinCodeSuggestion: Bool? = UserDefaults.standard.value(for: .pinCodeSuggestion)
        
        guard pinCodeSuggestion != true else {
            return
        }
        
        let alert = UIAlertController(
            title: "PIN Code",
            message: "For a better experience, you can enter the ORTUS PIN code in the Settings. Then you can access ORTUS and e-courses without typing it.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Later", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { [unowned self] _ in
            self.viewModel.router.openSettings()
        }))
        
        present(alert, animated: true, completion: {
            UserDefaults.standard.set(true, for: .pinCodeSuggestion)
        })
    }
}

extension HomeViewController {
    func prepareNavigationItem() {
        var settingsImage: UIImage?
        
        if #available(iOS 13.0, *) {
            settingsImage = UIImage(systemName: "gear")
        } else {
            settingsImage = Asset.Images.settings.image
        }
        
        let settingsItem = UIBarButtonItem(
            image: settingsImage,
            style: .plain,
            target: self,
            action: #selector(openSettings))
        navigationItem.rightBarButtonItem = settingsItem
        
        navigationItem.title = L10n.Home.title
    }
}
