//
//  WebViewController.swift
//  GankIO
//
//  Created by ZhuDuan on 16/2/4.
//  Copyright © 2016年 Anthony. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    var loadURL = ""
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var progressView: UIProgressView!
    
    var myTimer: NSTimer!
    var theBool: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        webView.loadRequest(NSURLRequest(URL: NSURL(string: loadURL)!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        self.progressView.progress = 0.0
        self.theBool = false
        self.myTimer = NSTimer.scheduledTimerWithTimeInterval(0.01667, target: self, selector: "timeCallBack", userInfo: nil, repeats: true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.theBool = true
    }
    
    func timeCallBack() {
        if (self.theBool != nil) {
            if self.progressView.progress >= 1 {
                self.progressView.hidden = true
                self.myTimer.invalidate()
            } else {
                self.progressView.progress += 0.1
            }
        } else {
            self.progressView.progress += 0.5
            if self.progressView.progress >= 0.95 {
                self.progressView.progress = 0.95
            }
        }
    }

}
