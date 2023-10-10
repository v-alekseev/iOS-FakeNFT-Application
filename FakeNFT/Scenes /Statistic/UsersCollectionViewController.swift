//
//  UsersCollectionViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit

final class UsersCollectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(tapBackButton))
        leftBarButton.tintColor = .ypBlackWithDarkMode
        self.navigationItem.leftBarButtonItem  = leftBarButton

        navigationItem.title = "Коллекция NFT"
        navigationItem.titleView?.tintColor = .ypBlackWithDarkMode

        view.backgroundColor = .green

        NSLayoutConstraint.activate([

        ])
    }

    @objc
    private func tapBackButton() {
        navigationController?.popViewController(animated: true)
    }

}
