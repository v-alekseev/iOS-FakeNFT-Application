//
//  WebViewViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 14.10.2023.
//

import UIKit
import WebKit

final class WebViewViewController: UIViewController {
    
    private var alertPresenter = Alert.shared
    private var url: String
    private lazy var webView = createWebView()
    private lazy var progressBar = createProgressBar()
    
    init(_ url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if let weburl = URL(string: url) {
            webView.load(URLRequest(url: weburl))
        } else {
            alertPresenter.showAlert(self)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.addObserver(
            self,
            forKeyPath: #keyPath(WKWebView.estimatedProgress),
            options: .new,
            context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.estimatedProgress) {
            let progressValue = Float(webView.estimatedProgress)
            progressBar.setProgress(progressValue, animated: true)
            if abs(progressValue - 1.0) <= 0.0001 {
                progressBar.isHidden = true
                progressBar.setProgress(0, animated: false)
            } else {
                progressBar.isHidden = false
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    private func setupView() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tapBackButton))
        leftBarButton.tintColor = .ypBlackWithDarkMode
        navigationItem.leftBarButtonItem  = leftBarButton
        
        view.backgroundColor = .ypWhiteWithDarkMode
        view.addSubview(webView)
        view.addSubview(progressBar)
        
        NSLayoutConstraint.activate([
            
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progressBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 2)
            
        ])
    }
    
    private func createWebView() -> WKWebView {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }
    
    private func createProgressBar() -> UIProgressView {
        let progressBar = UIProgressView(progressViewStyle: .default)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.backgroundColor = .ypLightGreyWithDarkMode
        progressBar.tintColor = .ypBlackWithDarkMode
        progressBar.setProgress(0, animated: true)
        return progressBar
    }
    
    @objc
    private func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
}
