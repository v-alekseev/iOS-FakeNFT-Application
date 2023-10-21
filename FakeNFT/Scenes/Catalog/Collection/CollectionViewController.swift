//
//  CollectionViewController.swift
//  FakeNFT
//
//  Created by Александр Поляков on 14.10.2023.
//

import UIKit
import ProgressHUD

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
        tv.isScrollEnabled = true
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    init (collection: CollectionModel, viewModel: CollectionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIViewController(*)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        setupUI()
        bind()
        view.backgroundColor = .ypWhiteWithDarkMode
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CollectionHeaderTableViewCell.self)
        tableView.register(NFTsTableViewCell.self, forCellReuseIdentifier: "NFTsCell")
    }
    
    // MARK: - Rendering
    func renderState(state: CollectionResultState) {
        switch state {
        case .start:
            ProgressHUD.dismiss()
            break
        case .loading:
            tableView.isHidden = true
            ProgressHUD.show()
        case .error:
            ProgressHUD.dismiss()
            showErrorAlert()
            break
        case .showCollection:
            ProgressHUD.dismiss()
            tableView.isHidden = false
            tableView.reloadData()
            break
        }
    }
    
    func renderState(state: CollectionNavigationState) {
        switch state {
        case .backButtonTapped:
            viewModel.clearLinks()
            navigationController?.popViewController(animated: true)
        default:
            break
        }
    }
    
    // MARK: - Private Methods
    private func bind () {
        viewModel.bind(to: self)
    }
    
    private func setupButtons() {
        backButton.target = self
        backButton.action = #selector(handleBackButton)
    }
    
    private func showErrorAlert() {
        let alertPresenter = AlertPresenter()
        let alertModel = AlertModel(title: L10n.Alert.Error.title, message: L10n.Alert.Error.description, primaryButtonText: L10n.Alert.Error.retry) { [weak self] in
            guard let self = self else { return }
            self.viewModel.refresh(withCommonData: true)
        }
        alertPresenter.show(in: self, model: alertModel)
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
        tableView.estimatedRowHeight = 374
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc private func handleBackButton() {
        viewModel.handleInteractionType(.pop)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        switch section {
        case 0:
            let cell: CollectionHeaderTableViewCell = tableView.dequeueReusableCell()
            let data = viewModel.giveMeHeaderComponent()
            let imageSize = CGSize(width: tableView.bounds.width, height: 310)
            guard let author = data.author else {
                return cell
            }
            cell.configureCell(with: data.collection, author: author, imageSize: imageSize)
            return cell
        default:
            let rowsCount = ceil(CGFloat(viewModel.giveMeHeaderComponent().collection.nfts.count)/NFTsTableViewCell.numberOfColumns)
            let estimatedWidth = floor((tableView.bounds.width - 32 - 9 * (NFTsTableViewCell.numberOfColumns - 1))/NFTsTableViewCell.numberOfColumns)
            let estimatedHeightValue = 24 + (8 + floor(56 + 6 + (tableView.bounds.width - 32 - 9 * (NFTsTableViewCell.numberOfColumns - 1))/NFTsTableViewCell.numberOfColumns)) * rowsCount
//            print("estimated height value = \()")
            
            let cell = NFTsTableViewCell(
                style: .default,
                reuseIdentifier: "NFTsCell",
                estimatedHeight: estimatedHeightValue,
                estimatedCellWidth: estimatedWidth
            )
//            let cell: NFTsTableViewCell = tableView.dequeueReusableCell()
//            cell.estimatedHeight = 56 + 6 + (tableView.bounds.width - 32 - (cell.numberOfColumns - 1))/cell.numberOfColumns
            print("dataSource wanna be setted")
            if let dataSource = viewModel as? NFTDataSourceProtocol {
                print("dataSource setted")
                cell.setDataSource(with: dataSource)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return  UITableView.automaticDimension
        default:
            let rowsCount = ceil(CGFloat(viewModel.giveMeHeaderComponent().collection.nfts.count)/NFTsTableViewCell.numberOfColumns)
            let estimatedHeightValue = 24 + (8 + (56 + 6 + (tableView.bounds.width - 32 - (NFTsTableViewCell.numberOfColumns - 1))/NFTsTableViewCell.numberOfColumns)) * rowsCount
            return estimatedHeightValue
        }
    }
}
