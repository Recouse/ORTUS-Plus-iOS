//
//  NewsViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 21/03/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import Combine
import Carbon
import Promises

class NewsViewController: Module, ModuleViewModel {
    var viewModel: NewsViewModel
    
    weak var newsView: NewsView! { return view as? NewsView }
    weak var tableView: UITableView! { return newsView.tableView }
    
    var refreshControl: UIRefreshControl!
    
    let renderer = Renderer(
        adapter: UITableViewAdapter(),
        updater: UITableViewUpdater()
    )
    
    private var cancellables = Set<AnyCancellable>()
    
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
        
        userActivity = Shortcut(activity: .news).activity
        
        prepareNavigationItem()
        prepareRefreshControl()
        prepareData()
        
        loadData()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        let dates = viewModel.articles.keys.sorted(by: { $0.compare($1) == .orderedDescending })
        let articles = dates.compactMap { viewModel.articles[$0] }.flatMap { $0 }
        
        renderer.render {
            Section(
                id: "articles",
                cells: {
                    Group(of: articles) { article in
                        ArticleComponent(
                            id: article.title,
                            article: article,
                            onSelect: { [unowned self] in
                                self.viewModel.router.openArticle(article)
                            }
                        ).identified(by: \.article.title)
                    }
                }
            )
        }
    }

    func loadData(forceUpdate: Bool = false) {
        viewModel.loadArticles(forceUpdate: forceUpdate)
    }
    
    @objc func refresh() {
        loadData(forceUpdate: true)
    }
}

extension NewsViewController {
    func prepareNavigationItem() {        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: L10n.back,
            style: .plain,
            target: nil,
            action: nil)
        
        navigationItem.title = L10n.News.title
    }
    
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
        
        viewModel.$articles
            .receive(on: DispatchQueue.main)
            .sink { _ in
                self.render()
            }
            .store(in: &cancellables)
    }
}

