//
//  CourseViewController.swift
//  ORTUS
//
//  Created by Firdavs Khaydarov on 24/12/19.
//  Copyright (c) 2019 Firdavs. All rights reserved.
//

import UIKit
import WebKit

class CourseViewController: TranslatableModule, ModuleViewModel {
    var viewModel: CourseViewModel
    
    weak var courseView: CourseView! { return view as? CourseView }
    weak var loadingOverview: UIView! { return courseView.loadingOverview }
    
    var webView: WKWebView!
    
    var initialPinNavigation: WKNavigation?
    
    init(viewModel: CourseViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = CourseView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareNavigationItem()
        prepareWebView()
        prepareData()
        
        showLoadingOverview(animated: false)
    }
    
    override func prepareLocales() {
        navigationItem.title = viewModel.course.name
    }
    
    func showLoadingOverview(animated: Bool) {
        courseView.bringSubviewToFront(loadingOverview)
        
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
        UIView.animate(withDuration: 0.3, animations: {
            self.loadingOverview.alpha = 0
        }) { _ in
            self.loadingOverview.isHidden = true
        }
    }
}

extension CourseViewController {
    func prepareNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func prepareWebView() {
        let config = WKWebViewConfiguration()
        config.dataDetectorTypes = [.all]
        
        if let pinCode = viewModel.keychain[Global.Key.ortusPinCode] {
            let contentController = WKUserContentController()
            let script = String(format: CourseJS.script, pinCode)
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
        
        OAuth.refreshToken().then { accessTokenEncrypted in
            guard let url = self.viewModel.course.link.generatePinAuthURL(withToken: accessTokenEncrypted) else {
                return
            }

            self.initialPinNavigation = self.webView.load(URLRequest(url: url))
        }
        
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func prepareData() {
        
    }
}

extension CourseViewController: WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard let body = message.body as? NSDictionary, let event = body["key"] as? String else { return }
                
        if event == Global.Event.loggedIn {
            // A small hack to hide activity indicator after page loading
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
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
}
