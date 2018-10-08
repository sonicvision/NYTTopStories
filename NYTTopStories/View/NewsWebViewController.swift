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
//    var webView: WKWebView!
    var newsUrl: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: newsUrl)!
        newsWebView.load(URLRequest(url: url))
        newsWebView.navigationDelegate = self
        // Do any additional setup after loading the view.
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
//    override func loadView() {
//        webView = WKWebView()
//        webView.navigationDelegate = self
//        view = webView
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
