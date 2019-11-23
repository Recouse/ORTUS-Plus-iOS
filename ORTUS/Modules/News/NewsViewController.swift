//
//  NewsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Carbon

class NewsViewController: TranslatableModule, ModuleViewModel {
    var viewModel: NewsViewModel
    
    weak var newsView: NewsView! { return view as? NewsView }
    weak var tableView: UITableView! { return newsView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    lazy var renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = NewsView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    override func prepareLocales() {
        title = "news.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        let data = viewModel.articles.keys.sorted(by: { $0.compare($1) == .orderedDescending }).map {
            Section(
                id: $0.hashValue,
                header: ViewNode(ArticleSectionHeader(date: $0)),
                cells: (self.viewModel.articles[$0] ?? []).map { article in
                    CellNode(ArticleComponent(id: article.title, article: article))
                }
            )
        }
        
        renderer.render(data)
    }
    
    func loadData() {
        viewModel.loadArticles().catch { error in
            print(error)
        }.always {
            self.render()
        }
    }
    
    @objc func refresh() {
        loadData()
    }
    
    @objc func scrollToTop() {
        guard let tabBarController = navigationController?.tabBarController,
            tabBarController.selectedIndex == Global.UI.TabBar.news.rawValue,
            !tableView.visibleCells.isEmpty else {
            return
        }
        
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
}

extension NewsViewController {
    func prepareNavigationItem() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "back".localized(), style: .plain,
                                                           target: nil, action: nil)
    }
    
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
        renderer.adapter.didSelect = { [unowned self] context in
            guard let component = context.node.component(as: ArticleComponent.self) else {
                return
            }
            
            self.viewModel.router.openArticle(component.article)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollToTop), name: .scrollToTop, object: nil)
    }
}

