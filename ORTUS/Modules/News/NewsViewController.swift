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
    
    let renderer = Renderer(
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
        navigationItem.title = "news.title".localized()
    }
    
    func render() {
        refreshControl.endRefreshing()
        
        let dates = viewModel.articles.keys.sorted(by: { $0.compare($1) == .orderedDescending })
        
        renderer.render {
            Group(of: dates) { date in
                Section(
                    id: date.hashValue,
                    header: ArticleSectionHeader(date: date),
                    cells: {
                        Group(of: self.viewModel.articles[date] ?? []) { article in
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
}

extension NewsViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "back".localized(),
            style: .plain,
            target: nil,
            action: nil)
    }
    
    func prepareRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func prepareData() {
        renderer.target = tableView
    }
}

