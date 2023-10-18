//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit

final class CollectionViewController: UIViewController {
    private var viewModel: CollectionViewModelProtocol
    private var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = (UIImage(named: "BackwardIcon"))
        button.style = .plain
        button.tintColor = .ypBlackWithDarkMode
        return button
    }()
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Отдельная коллекция NFT"
        label.numberOfLines = 0
        label.font =  UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init (collection: CollectionModel, viewModel: CollectionViewModelProtocol) {
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
        setupButtons()
        setupUI()
        view.backgroundColor = .ypWhiteWithDarkMode
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CollectionHeaderTableViewCell.self)
    }
    // MARK: - Private Methods
    //
    
    private func setupButtons() {
        backButton.target = self
        backButton.action = #selector(handleBackButton)
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = backButton
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0.0
        var statusBarHeight: CGFloat {
            if #available(iOS 13.0, *) {
                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
                return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
            } else {
                return UIApplication.shared.statusBarFrame.height
            }
        }
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: -navigationBarHeight - statusBarHeight),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func handleBackButton() {
        viewModel.handleInteractionType(.pop)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfSections section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollectionHeaderTableViewCell = tableView.dequeueReusableCell()
        let data = viewModel.giveMeHeaderComponent()
        let imageSize = CGSize(width: tableView.bounds.width, height: 310)
        cell.configureCell(with: data.collection, author: data.author, imageSize: imageSize)
        return cell
    }
}
