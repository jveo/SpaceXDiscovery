//
//  WebViewController.swift
//  HikingProject
//
//  Created by Jesse viau on 2023-11-23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    //MARK: - Properties
    var webUrl: String!
    
    //MARK: - Outlets
    @IBOutlet weak var webView: WKWebView!
    
    //MARK: - View methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load the passed web url into the webview
        if let url = webUrl {
            webView.load(URLRequest(url: URL(string: url)!))
        } else { return }
        
    }
    

}
