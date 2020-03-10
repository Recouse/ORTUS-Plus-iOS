//
//  ArticleContentComponent.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 22/03/19.
//  Copyright © 2019 Firdavs. All rights reserved.
//

import UIKit
import SnapKit
import Carbon
import WebKit
import SafariServices
import Models

class ArticleContentComponent: IdentifiableComponent, Equatable, ArticleContentViewDelegate {    
    var onContentChange: (() -> Void)?
    
    var onLinkActivated: ((_ url: URL) -> Void)?
    
    var id: Int
    var article: Article
    
    init(id: Int, article: Article, onContentChange: (() -> Void)?, onLinkActivated: ((_ url: URL) -> Void)?) {
        self.id = id
        self.article = article
        self.onContentChange = onContentChange
        self.onLinkActivated = onLinkActivated
    }
    
    func renderContent() -> ArticleContentView {
        return ArticleContentView()
    }
    
    func render(in content: ArticleContentView) {
        content.delegate = self
        
        let html = """
            <html>
                <head>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
        
                    <style type="text/css">
                        body {font: -apple-system-body !important;}
                        table { width: 100% !important; }
                    </style>
                </head>
                <body>
                    \(article.text)
                </body>
            </html>
        """
        
        content.webView.loadHTMLString(html, baseURL: nil)
    }
    
    func referenceSize(in bounds: CGRect) -> CGSize? {
        return nil
    }
    
    func shouldContentUpdate(with next: ArticleContentComponent) -> Bool {
        return false
    }
    
    static func == (lhs: ArticleContentComponent, rhs: ArticleContentComponent) -> Bool {
        return lhs.article.id == rhs.article.id
    }
    
    func contentChanged() {
        onContentChange?()
    }
    
    func linkActivated(_ url: URL) {
        onLinkActivated?(url)
    }
}

protocol ArticleContentViewDelegate: class {
    func contentChanged()
    func linkActivated(_ url: URL)
}

class ArticleContentView: UIView, WKNavigationDelegate {
    weak var delegate: ArticleContentViewDelegate?
    
    let webView: WKWebView = {
        let view = WKWebView()
        view.scrollView.isScrollEnabled = false
        
        return view
    }()
    
    var height: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(webView)
        webView.snp.makeConstraints {
            self.height = $0.height.equalTo(0).constraint
            $0.top.equalToSuperview().offset(10)
            $0.left.right.equalToSuperview().offset(Global.UI.edgeInset).inset(Global.UI.edgeInset)
            $0.bottom.equalToSuperview()
        }
        webView.navigationDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.webView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    self.height?.update(offset: (height as! CGFloat) + 40)
                    self.delegate?.contentChanged()
                })
            }

        })
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.navigationType == .linkActivated,
            let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if url.scheme == "tel" || url.scheme == "mailto" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                return
            }
        }
        
        self.delegate?.linkActivated(url)
        
        decisionHandler(.cancel)
    }
}

