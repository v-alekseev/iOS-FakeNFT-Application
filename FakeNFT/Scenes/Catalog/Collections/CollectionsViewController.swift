//
//  StatisticViewController.swift
//  FakeNFT
//
//  Created by Vitaly on 08.10.2023.
//

import Foundation
import UIKit
import ProgressHUD

final class CollectionsViewController: UIViewController {
    
    private var viewModel: CollectionsViewModelProtocol
    private var filterBarButtonItem: UIBarButtonItem?
    private let refreshControl = UIRefreshControl()
    
    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.backgroundColor = .clear
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    init(viewModel: CollectionsViewModelProtocol = CollectionsViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.refresh()
        setupButtons()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CollectionsTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        view.backgroundColor = .ypWhiteWithDarkMode
        print("CatalogViewController viewDidLoad")
        
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        navigationItem.rightBarButtonItem = filterBarButtonItem
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func setupButtons() {
        filterBarButtonItem = {
            let barButtonItem = UIBarButtonItem(
                image: UIImage (named: "SortIcon" ),
                style: .plain,
                target: self,
                action: #selector (filterButtonTapped)
            )
            barButtonItem.tintColor = .ypBlackWithDarkMode
            return barButtonItem
        }()
    }
    
    // MARK: - Objc Methods
    @objc
    private func filterButtonTapped() {
        print("filterButtonTapped")
        showSortSelector()
    }
    
    @objc
    private func didPullToRefresh() {
        viewModel.handleNavigation(action: .pullToRefresh)
    }
    
    // MARK: - Private Methods
    private func bind () {
        viewModel.bind(to: self)
    }
    
    private func showSortSelector() {
        let alertController = UIAlertController(title: nil, message: L10n.Catalog.sort, preferredStyle: .actionSheet)
        
        let sortActionByName = UIAlertAction(title: L10n.Catalog.Sort.byName, style: .default) { _ in
            self.viewModel.handleNavigation(action: .sortDidSelected(which: .byName(order: .ascending)))
        }
        
        let sortActionByNFTQuantity = UIAlertAction(title: L10n.Catalog.Sort.byNFTQuantity, style: .default) { _ in
            self.viewModel.handleNavigation(action: .sortDidSelected(which: .byNFTQuantity(order: .ascending)))
        }
        
        let closeAction = UIAlertAction(title: L10n.Catalog.Sort.close, style: .cancel) { _ in
            self.viewModel.handleNavigation(action: .sortIsCancelled)
        }
        
        alertController.addAction(sortActionByName)
        alertController.addAction(sortActionByNFTQuantity)
        alertController.addAction(closeAction)
        
        present(alertController, animated: true)
    }
    
    // MARK: - Rendering
    func renderState(state: CollectionsNavigationState) {
        switch state {
        case .base:
            break
        case .sortSelection:
            showSortSelector()
        case .collectionDetails(let collection):
            navigationController?.pushViewController(CollectionViewController(collection: collection, viewModel: viewModel.giveMeCollectionViewModel(for: collection)), animated: true)
        case .sort:
            break
        case .pullToRefresh:
            tableView.refreshControl?.beginRefreshing()
            viewModel.refresh()
        }
    }
    
    func renderState(state: CollectionsResultState) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            switch state {
            case .error:
                ProgressHUD.dismiss()
                self.showErrorAlert()
            case .loading:
                ProgressHUD.show()
            case .show:
                ProgressHUD.dismiss()
                self.tableView.reloadData()
            case .start:
                ProgressHUD.dismiss()
            }
        }
    }
    
    // MARK: - Alert Error
    private func showErrorAlert() {
        let alertPresenter = AlertPresenter()
        let alertModel = AlertModel(title: L10n.Alert.Error.title, message: L10n.Alert.Error.description, primaryButtonText: L10n.Alert.Error.retry) { [weak self] in
            guard let self = self else { return }
            self.viewModel.refresh()
        }
        alertPresenter.show(in: self, model: alertModel)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CollectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.howManyCollections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollectionsTableViewCell = tableView.dequeueReusableCell()
        guard let model = viewModel.getCollection(at: indexPath) else { return cell }
        cell.configureCell(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let model = viewModel.getCollection(at: indexPath) else { return }
        viewModel.handleNavigation(action: .collectionDidTapped(collection: model))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CollectionsTableViewCell.cellHeight
    }
}
