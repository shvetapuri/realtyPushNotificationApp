//
//  ViewController.swift
//  RealtyPushNotification
//
//  Created by Shveta Puri on 11/12/20.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    var url = ""
   // let newsStore = NewsStore.shared

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("in viewcontroller", url)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotUrl(notifData:)), name: Notification.Name(rawValue: "url"), object: nil)

       if let url1 =  UserDefaults.standard.value(forKey: "url") as? String {
            print(url1)
            url = url1
        }
        
        
        if (url == "") {
            url = "https://www.google.com"
        }
        let urlToLoad = URL(string: url )!
        webView?.load(URLRequest(url: urlToLoad))
        webView?.allowsBackForwardNavigationGestures = true

        
//        print(newsStore.items)
//        if (newsStore.items.count != 0) {
//            newsLabel.text = newsStore.items[0].title
//        }
        
        
    }
    @objc func gotUrl(notifData : Notification){
        let url = notifData.object as! String
        var urlToLoad: URL
        if (url != "") {
            print("in goturl", url)

            urlToLoad = URL(string: url )!
            webView?.load(URLRequest(url: urlToLoad))
           
        }
    }
//     func newUrlAvailable(url: String) {
//        print("hi")
//        var urlToLoad: URL
//        if (url != "") {
//            urlToLoad = URL(string: url )!
//            webView?.load(URLRequest(url: urlToLoad))
//            webView.reload()
//        }
//    }
//
    @IBAction func backButtonAction(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        webView.goForward()
    }
    
}


