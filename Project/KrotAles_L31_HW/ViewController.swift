//
//  ViewController.swift
//  KrotAles_L31_HW
//
//  Created by Ales Krot on 5.02.22.
//

import UIKit
import WebKit
import SafariServices

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var adressBarTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        adressBarTextField.delegate = self
        
//        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func downloadPage(link: String) {
        var components = URLComponents(string: link)
        
        if components?.scheme == nil {
            components?.scheme = "https"
            guard let url = components?.url else { return }
            let request = URLRequest(url: url)
            webView.load(request)
        } else {
            guard let url = URL(string: link) else { return }
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressForwardButton(_ sender: UIButton) {
        
    }
    
    @IBAction func didPressRefreshButton(_ sender: UIButton) {
        
    }
}

extension ViewController: WKNavigationDelegate, WKUIDelegate, UITextFieldDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == adressBarTextField {
            guard let urlString = textField.text else { return true }
            print(urlString)
            textField.resignFirstResponder()
            downloadPage(link: urlString)
        }
        return true
    }
}

extension ViewController: WKScriptMessageHandler {
    
}
