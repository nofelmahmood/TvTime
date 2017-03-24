//
//  WebViewController.swift
//  TvTime
//
//  Created by Nofel Mahmood on 14/03/2017.
//  Copyright © 2017 Nineish. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    lazy var webView: UIWebView = {
        let wV = UIWebView()
        wV.translatesAutoresizingMaskIntoConstraints = false
        
        return wV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(webView)
        
        webView.pinEdgesToSuperview()
        webView.delegate = self
        
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(onCancelBarButtonPress))
        navigationItem.rightBarButtonItem = cancelBarButtonItem
        
        let urlString = "\(APIEndPoint.traktAuthorize)?response_type=code&client_id=\(API.traktClientID)&redirect_uri=\(API.redirectURI)"
        
        let urlRequest = URLRequest(url: URL(string: urlString)!)
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - User Interaction
    
    func onCancelBarButtonPress() {
        dismiss(animated: true, completion: nil)
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

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        if let absoluteString = webView.request?.url?.absoluteString, absoluteString.hasPrefix("https://www.google.com.pk/") {
            let urlComponents = NSURLComponents(url: webView.request!.url!, resolvingAgainstBaseURL: false)
            
            let param = "code"
            
            let authorizationCode = (urlComponents?.queryItems as [NSURLQueryItem]?)?
                .filter({ item in
                    item.name == param
                }).first?.value
            
            Trakt.shared.getAccessToken().then(execute: { (result) -> Void in
                print("Access Token is \(result)")
            })
        }
        print("Request is \(webView.request)")
    }
}
