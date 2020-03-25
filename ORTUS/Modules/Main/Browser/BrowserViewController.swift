//
//  BrowserViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: TranslatableModule, ModuleViewModel {
    var viewModel: BrowserViewModel
    
    weak var browserView: BrowserView! { return view as? BrowserView }
    weak var loadingOverview: UIView! { return browserView.loadingOverview }
    
    var webView: WKWebView!
    
    var initialPinNavigation: WKNavigation?
    
    var progressView: UIProgressView!
    
    var previousPageItem: UIBarButtonItem!
    var nextPageItem: UIBarButtonItem!
    var shareItem: UIBarButtonItem!
    var refreshItem: UIBarButtonItem!
    
    init(viewModel: BrowserViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = BrowserView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareToolbarItems()
        prepareWebView()
        prepareProgressView()
        prepareData()
        
        showLoadingOverview(animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch keyPath {
        case #keyPath(WKWebView.title):
            navigationItem.title = webView.title
        case #keyPath(WKWebView.canGoBack):
            previousPageItem.isEnabled = webView.canGoBack
        case #keyPath(WKWebView.canGoForward):
            nextPageItem.isEnabled = webView.canGoForward
        case #keyPath(WKWebView.estimatedProgress):
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        default:
            break
        }
    }
    
    func showLoadingOverview(animated: Bool) {
        browserView.bringSubviewToFront(loadingOverview)
        
        if animated {
            loadingOverview.alpha = 0
            loadingOverview.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.loadingOverview.alpha = 1
            })
        } else {
            loadingOverview.alpha = 1
            loadingOverview.isHidden = false
        }
    }
    
    func hideLoadingOverview() {
        refreshItem.isEnabled = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingOverview.alpha = 0
        }) { _ in
            self.loadingOverview.isHidden = true
        }
    }
    
    @objc func previousPage() {
        webView.goBack()
    }
    
    @objc func nextPage() {
        webView.goForward()
    }
    
    @objc func share() {
        guard let url = webView.url else {
            return
        }
        
        let activityController = UIActivityViewController(
            activityItems: [url, webView.viewPrintFormatter()],
            applicationActivities: nil
        )

        present(activityController, animated: true, completion: nil)
    }
    
    @objc func refresh() {
        webView.reload()
    }
}

extension BrowserViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func prepareToolbarItems() {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        previousPageItem = UIBarButtonItem(
            image: UIImage(named: "chevronLeft"),
            style: .plain,
            target: self,
            action: #selector(previousPage))
        previousPageItem.isEnabled = false
        
        nextPageItem = UIBarButtonItem(
            image: UIImage(named: "chevronRight"),
            style: .plain,
            target: self,
            action: #selector(nextPage))
        nextPageItem.isEnabled = false
        
        shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
        
        refreshItem = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refresh))
        refreshItem.isEnabled = false
        
        toolbarItems = [previousPageItem, spacer, nextPageItem, spacer, shareItem, spacer, refreshItem]
    }
    
    func prepareWebView() {
        let config = WKWebViewConfiguration()
        config.dataDetectorTypes = [.all]
        
        if let pinCode = viewModel.keychain[Global.Key.ortusPinCode] {
            let contentController = WKUserContentController()
            let js = viewModel.loadBrowserJS()
            let script = String(format: js, pinCode)
            let userScript = WKUserScript(
                source: script,
                injectionTime: .atDocumentEnd,
                forMainFrameOnly: true)
            contentController.addUserScript(userScript)
            contentController.add(self, name: Global.Key.courseJSHandler)

            config.userContentController = contentController
        }
        
        webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        
        OAuth.refreshToken().then { accessTokenEncrypted in
            guard let url = self.viewModel.url.generatePinAuthURL(withToken: accessTokenEncrypted) else {
                return
            }

            self.initialPinNavigation = self.webView.load(URLRequest(url: url))
        }
        
        let edgeInsets = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: view.safeAreaInsets.bottom,
            right: 0)
        webView.scrollView.contentInset = edgeInsets
        webView.setValue(edgeInsets, forKey: "_obscuredInsets")
        webView.setValue(true, forKey: "_haveSetObscuredInsets")
        
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func prepareProgressView() {
        progressView = UIProgressView(progressViewStyle: .bar)
        progressView.tintColor = Asset.Colors.tintColor.color
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
        }
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    func prepareData() {
        
    }
}

extension BrowserViewController: WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? NSDictionary, let event = body["key"] as? String else {
            return
        }
        
        if event == Global.Event.loggedIn {
            // A small hack to hide activity indicator after page loading
            DispatchQueue.main.async {
                self.hideLoadingOverview()
            }
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }

        return nil
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.navigationType == .linkActivated,
            let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        print(url)
        
        if url.scheme == "tel" || url.scheme == "mailto" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                return
            }
        }
        
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.setProgress(0, animated: false)
    }
}
