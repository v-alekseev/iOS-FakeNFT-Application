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
    private var tableView: UITableView?
    // MARK: - Private Properties
    //
    private var textLabel: UILabel = {
        var label = UILabel()
        label.text = "Каталог"
        label.font =  UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setupButtons()
        
        setupUI()
        
        bind()
        view.backgroundColor = .white
        print("CatalogViewController viewDidLoad")
    }
    // MARK: - Private Methods
    //
    private func setupUI() {
        navigationItem.rightBarButtonItem = filterBarButtonItem
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
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
            barButtonItem.tintColor = UIColor (named: "blackWithDarkMode")
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
        switch state {
        case .error:
            ProgressHUD.dismiss()
            print("error")
        case .loading:
            ProgressHUD.show()
        case .show:
            ProgressHUD.dismiss()
            print("show")
        case .start:
            ProgressHUD.dismiss()
            print("start")
        }
    }
}
