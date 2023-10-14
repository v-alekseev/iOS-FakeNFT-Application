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
    private var viewModel: CollectionsViewModelProtocol = CollectionsViewModel()
    private var filterBarButtonItem: UIBarButtonItem?

    private let tableView: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.refresh()
        setupButtons()
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CollectionsTableViewCell.self, forCellReuseIdentifier: "CollectionCell")
        view.backgroundColor = .white
        print("CatalogViewController viewDidLoad")
        
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        navigationItem.rightBarButtonItem = filterBarButtonItem
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
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
    
    @objc
    private func filterButtonTapped() {
        print("filterButtonTapped")
        showSortSelector()
    }
    
    private func bind () {
        self.viewModel.navigationClosure = {[weak self] state in
            guard let self = self else { return }
            self.renderState(state: state)
        }
        
        self.viewModel.resultClosure = {[weak self] state in
            guard let self = self else { return }
            self.renderState(state: state)
        }
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
    
    private func renderState(state: CollectionsNavigationState) {
        switch state {
        case .base:
            print("base")
        case .sortSelection:
            showSortSelector()
        case .collectionDetails(let collection):
            print(collection)
        case .sort(let type):
            print(type)
        }
    }
    
    private func renderState(state: CollectionsResultState) {
        DispatchQueue.main.async {
            switch state {
            case .error:
                ProgressHUD.dismiss()
                print("error")
            case .loading:
                ProgressHUD.show()
                print("loading")
            case .show:
                ProgressHUD.dismiss()
                print("show \(self.viewModel.howManyCollections()))")
                self.tableView.reloadData()
            case .start:
                ProgressHUD.dismiss()
                print("start")
            }
        }
    }
}

extension CollectionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.howManyCollections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! CollectionsTableViewCell
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
