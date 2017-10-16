//
//  WebViewController.swift
//  PeekAndPop
//
//  Created by Harvey on 2017/10/16.
//  Copyright © 2017年 Harvey. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var url: String!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.webView.loadRequest(URLRequest(url: URL(string: self.url)!))
    }
}

