//
//  WebViewController.swift
//  SwiftTestProject1
//
//  Created by sjr on 16/8/30.
//  Copyright © 2016年 dianwangjr. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var alt: String?
    
    var progressHUD: MBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        if (self.alt != nil) {
            self.webView.loadRequest(URLRequest.init(url: URL.init(string: self.alt!)!))
            self.progressHUD = MBProgressHUD.showAdded(to: self.webView, animated: true)
        }
    }
}

extension WebViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.progressHUD!.hide(animated: true)
    }
}


