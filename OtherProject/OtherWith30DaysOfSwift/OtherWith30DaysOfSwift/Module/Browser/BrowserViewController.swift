//
//  BrowserViewController.swift
//  OtherWith30DaysOfSwift
//
//  Created by HalseyW-15 on 2019/9/4.
//  Copyright © 2019 wushhhhhh. All rights reserved.
//

import UIKit
import WebKit

class BrowserViewController: UIViewController {
    let webView = WKWebView()
    let pbLoad = UIProgressView()
    let btnBack = UIButton()
    let btnForward = UIButton()

    var url: String = "https://www.apple.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        webView.load(url)
        webView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            btnBack.isEnabled = webView.canGoBack
            btnForward.isEnabled = webView.canGoForward
        }
        if keyPath == "estimatedProgress" {
            pbLoad.isHidden = webView.estimatedProgress == 1
            pbLoad.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
}

extension BrowserViewController {
    func initView() {
        self.view.backgroundColor = .white
        
        let topBar = UIView()
        topBar.backgroundColor = .lightGray
        self.view.addSubview(topBar)
        topBar.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(44)
            } else {
                make.height.equalTo(44)
            }
        }
        
        let tfUrl = UITextField()
        tfUrl.placeholder = "https://"
        tfUrl.textContentType = .URL
        tfUrl.clearButtonMode = .whileEditing
        tfUrl.backgroundColor = .white
        tfUrl.borderStyle = .roundedRect
        topBar.addSubview(tfUrl)
        tfUrl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        pbLoad.isHidden = true
        topBar.addSubview(pbLoad)
        pbLoad.snp.makeConstraints { (make) in
            make.width.bottom.equalToSuperview()
        }
        
        let bottomBar = UIView()
        bottomBar.backgroundColor = .lightGray
        self.view.addSubview(bottomBar)
        bottomBar.snp.makeConstraints { (make) in
            make.bottom.width.equalToSuperview()
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-44)
            } else {
                make.height.equalTo(44)
            }
        }
        
        btnBack.setTitle("Back", for: .normal)
        btnBack.setTitleColor(.white, for: .disabled)
        btnBack.setTitleColor(.blue, for: .normal)
        btnBack.isEnabled = false
        bottomBar.addSubview(btnBack)
        btnBack.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
        }
        
        btnForward.setTitle("Forward", for: .normal)
        btnForward.setTitleColor(.white, for: .disabled)
        btnForward.setTitleColor(.blue, for: .normal)
        btnForward.isEnabled = false
        bottomBar.addSubview(btnForward)
        btnForward.snp.makeConstraints { (make) in
            make.left.equalTo(btnBack.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        let btnReload = UIButton()
        btnReload.setTitleColor(.blue, for: .normal)
        btnReload.setTitle("Reload", for: .normal)
        bottomBar.addSubview(btnReload)
        btnReload.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(10)
        }
        
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.bottom.equalTo(bottomBar.snp.top)
            make.top.equalTo(topBar.snp.bottom)
        }
    }
}

extension WKWebView {
    func load(_ url: String) {
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            self.load(request)
        }
    }
}
