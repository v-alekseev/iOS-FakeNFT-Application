//
//  SingleCollectionViewController.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit

final class NFTViewController: UIViewController {
    private var viewModel: NFTViewModelProtocol
    // MARK: - Private Properties
    //
    private var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Отдельная коллекция NFT"
        label.numberOfLines = 0
        label.font =  UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init (collection: CollectionModel, viewModel: NFTViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.textLabel.text = "Отдельная \nколлекция \nNFT: \n\(collection.name)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - UIViewController(*)
    //
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        view.backgroundColor = .white
        print("CartViewController viewDidLoad")
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
