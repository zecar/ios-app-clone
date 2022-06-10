//
//  WebViewController.swift
//  LClone
//
//  Created by Ionut Capraru on 09.06.2022.
//

import Foundation
import SwiftUI
import WebKit
import Network

class WebViewController: UIViewController, WKNavigationDelegate {
    var wv: WKWebView
    let configuration = WKWebViewConfiguration()
    let preferences = WKPreferences()
    let contentController = WKUserContentController()
    
    init() {
        preferences.javaScriptEnabled = true
        configuration.userContentController = contentController
        configuration.preferences = preferences
        configuration.allowsInlineMediaPlayback = true
        
        self.wv = WKWebView(frame: .zero, configuration: configuration)
        self.wv.scrollView.bounces = false
        
        
        super.init(nibName: nil, bundle: nil)
        
        self.wv.layer.borderWidth = 15
        self.wv.layer.borderColor = UIColor.red.cgColor
        self.wv.isOpaque = false
        self.wv.backgroundColor = UIColor.yellow
    }
    
    required init?(coder: NSCoder) {
        preferences.javaScriptEnabled = true
        configuration.userContentController = contentController
        configuration.preferences = preferences
        configuration.allowsInlineMediaPlayback = true
        
        self.wv = WKWebView(frame: .zero, configuration: configuration)
        self.wv.scrollView.bounces = false
        
        
        super.init(coder: coder)
        
        self.wv.layer.borderWidth = 15
        self.wv.layer.borderColor = UIColor.red.cgColor
        self.wv.isOpaque = false
        self.wv.backgroundColor = UIColor.yellow
    }
    
    override func loadView() {
        self.wv.navigationDelegate = self
        self.view = self.wv
        self.load()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            self.wv.scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func load(){
        let pageHtmlPath = Bundle.main.path(forResource: "page", ofType: "html")
        
        let Url: URL = URL(fileURLWithPath: pageHtmlPath!)
        let request = URLRequest(url: Url)
        self.wv.load(request)
    }
}

struct WebView: View {
    typealias UIViewControllerType = UIViewController
    
    var body: some View {
        if #available(iOS 14.0, *) {
            WebViewRepresentable().edgesIgnoringSafeArea(.all).ignoresSafeArea(edges: .bottom)
        } else {
            // Fallback on earlier versions
            WebViewRepresentable().edgesIgnoringSafeArea(.all)
        }
    }
    
    struct WebViewRepresentable: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<WebView.WebViewRepresentable>) -> UIViewController {

            return WebViewController()
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<WebView.WebViewRepresentable>) {
        }
    }
}
