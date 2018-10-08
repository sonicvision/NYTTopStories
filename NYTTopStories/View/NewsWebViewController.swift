//
//  NewsWebViewController.swift
//  NYTTopStories
//
//  Created by Aarti Rustagi on 08/10/18.
//  Copyright © 2018 Proapptive Solutions. All rights reserved.
//

import UIKit
import WebKit

class NewsWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var newsWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var newsUrl: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: newsUrl)!
        newsWebView.load(URLRequest(url: url))
        newsWebView.navigationDelegate = self
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
