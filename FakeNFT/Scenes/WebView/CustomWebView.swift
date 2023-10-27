//
//  CustomWebView.swift
//  FakeNFT
//
//  Created by Александр Поляков on 23.10.2023.
//

import UIKit

final class CustomWebView: WebViewViewController {
    private lazy var backButton: UIBarButtonItem = {
           let button = UIBarButtonItem()
           button.image = (UIImage(resource: .backwardIcon))
           button.style = .plain
           button.tintColor = .ypBlackWithDarkMode
           button.target = self
           button.action = #selector(backButtonTapped)
           return button
       }()
    
    override init(viewModel: WebViewViewModelProtocol?, url: URL?) {
            super.init(viewModel: viewModel, url: url)
            navigationItem.leftBarButtonItem = backButton
        }
    
    @objc private func backButtonTapped() {
        if super.webView.canGoBack {
            super.webView.goBack()
            } else {
                navigationController?.popViewController(animated: true)
            }
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
