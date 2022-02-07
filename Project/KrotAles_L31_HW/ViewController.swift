//
//  ViewController.swift
//  KrotAles_L31_HW
//
//  Created by Ales Krot on 5.02.22.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var adressBarTextField: UITextField!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    var links = Stack()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.navigationDelegate = self
        adressBarTextField.delegate = self
        
        if links.peek() == nil {
            backButton.isEnabled = false
            forwardButton.isEnabled = false
        }
//        webView.allowsBackForwardNavigationGestures = true
    }
    
    private func downloadPage(link: String) {
        var components = URLComponents(string: link)
        
        if components?.scheme == nil {
            components?.scheme = "https"
        }
        
        guard let url = components?.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        links.push(url)
    }
    
    @IBAction func didPressBackButton(_ sender: UIButton) {
        if links.peek() == nil {
            backButton.isEnabled = false
        }
        guard let url = links.pop() else { return }
        let urlString = url.absoluteString
        downloadPage(link: urlString)
    }
    
    @IBAction func didPressForwardButton(_ sender: UIButton) {
        guard let url = links.peek() else { return }
        let urlString = url.absoluteString
        downloadPage(link: urlString)
    }
    
    @IBAction func didPressRefreshButton(_ sender: UIButton) {
        webView.reload()
    }
}

extension ViewController: WKNavigationDelegate, WKUIDelegate, UITextFieldDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let url = webView.url else { return }
        adressBarTextField.text = url.absoluteString
        print(url)
        
        backButton.isEnabled = true
        forwardButton.isEnabled = true
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
