//
//  ArticleViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon
import SafariServices

class ArticleViewController: Module, ModuleViewModel, AlertPresentable {
    var viewModel: ArticleViewModel
    
    var translateBarButtonItem: UIBarButtonItem!
    
    weak var articleView: ArticleView! { return view as? ArticleView }
    weak var tableView: UITableView! { return articleView.tableView }
    
    let headerView = ArticleHeaderComponentView()
    
    private let kTableHeaderHeight: CGFloat = 220
    
    lazy var adapter: ArticleTableViewAdapter = {
        let adapter = ArticleTableViewAdapter()
        adapter.delegate = self
        
        return adapter
    }()
    
    lazy var renderer = Renderer(
        adapter: adapter,
        updater: UITableViewUpdater()
    )
    
    var statusBarStyle: UIStatusBarStyle = .lightContent
    
    var navigationBarObserver: NSKeyValueObservation?
    
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.statusBarStyle
    }
    
    override func loadView() {
        view = ArticleView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareHeaderView()
        prepareData()
        
        render()
    }
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: UIScreen.main.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        
        headerView.frame = headerRect
    }
    
    func render() {
        renderer.render {
            Section(id: "article") {
                ArticleTitleComponent(article: viewModel.article)
                    .identified(by: \.article.id)
                
                ArticleContentComponent(
                    id: viewModel.article.id,
                    article: viewModel.article,
                    onContentChange: { [unowned self] in
                        self.updateTableView()
                    },
                    onLinkActivated: { [unowned self] url in
                        self.handle(url)
                    }
                )
            }
        }
    }
    
    func updateTableView() {
        UIView.performWithoutAnimation {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func handle(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        
        UIApplication.shared.open(url, options: [.universalLinksOnly: true]) { (success) in
            if !success {
                let vc = SFSafariViewController(url: url)
                self.present(vc, animated: true)
            }
        }
    }
    
    @objc func translate() {
        alert(type: .info, message: "This will be available soon!")
    }
    
    fileprivate func updateStatusBar(offset: CGFloat) {
        let statusBarCurrentStyle = statusBarStyle
        
        if offset >= 1 {
            statusBarStyle = .default
        } else {
            statusBarStyle = .lightContent
        }
        
        if statusBarStyle != statusBarCurrentStyle {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension ArticleViewController {
    func prepareNavigationItem() {
        navigationBarObserver = navigationController?.navigationBar.observe(
            \.bounds,
            options: [.new],
            changeHandler: { (navigationBar, changes) in
                if let height = changes.newValue?.height {
                    if height > 44 {
                        self.updateStatusBar(offset: 0)
                    } else {
                        self.updateStatusBar(offset: 1)
                    }
                }
            }
        )
    }
    
    func prepareHeaderView() {
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        
        updateHeaderView()
    }
    
    func prepareData() {
        renderer.target = tableView
        
        if let imageURL = viewModel.article.imageURL {
            headerView.imageView.kf.setImage(with: URL(string: imageURL), completionHandler:  { [weak self] result in
                guard let self = self, case .success = result else {
                    return
                }
                
                self.headerView.imageViewOverlay.isHidden = false
            })
        }
    }
}

extension ArticleViewController: ArticleTableViewAdapterDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}
