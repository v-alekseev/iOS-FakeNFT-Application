
//
//  CatalogViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 08.10.2023.
//

import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - Private Properties
    //
    private lazy var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Профайл"
        label.font =  UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - UIViewController(*)
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = .white
        print("ProfileViewController viewDidLoad")
    }
    // MARK: - Private Methods
    //
    private func setupUI() {
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
