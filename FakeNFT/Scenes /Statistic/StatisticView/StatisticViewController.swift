//
//  StatisticViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 17.10.2023.
//

import UIKit
import Combine

final class StatisticViewController: UIViewController {
    
    private let contentView = StatisticView()
    private let viewModel: StatisticViewModel
    private var alertPresenter = AlertPresenter.shared
    private var bindings = Set<AnyCancellable>()
    
    init(_ viewModel: StatisticViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = contentView
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filterButton"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(tapOnFilter))
        filterButton.tintColor = .ypBlackWithDarkMode
        navigationItem.rightBarButtonItem  = filterButton
        
        bindViewToViewModel()
        bindViewModelToView()
        
    }
    
    func bindViewToViewModel() {
        
        contentView.$needRefreshTable
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] needRefreshTable in
                if needRefreshTable {
                    self?.viewModel.loadUsersData()
                    self?.contentView.needRefreshTable = false
                }
            })
            .store(in: &bindings)
        
        contentView.$selectedRow
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] selectedRow in
                self?.viewModel.rowForOpenUserCard = selectedRow
            })
            .store(in: &bindings)
        
    }
    
    func bindViewModelToView() {
        
        viewModel.$usersData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] usersData in
                self?.contentView.usersData = usersData
                self?.contentView.reloadTable()
            })
            .store(in: &bindings)
        
        viewModel.$isLoading
            .assign(to: \.isLoading, on: contentView)
            .store(in: &bindings)
        
        viewModel.$loadError
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] loadError in
                if loadError {
                    self?.alertPresenter.showAlert(self) {_ in
                        self?.viewModel.loadUsersData()
                    }
                }
            })
            .store(in: &bindings)
        
        viewModel.$actualUserData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] actualUserData in
                guard let actualUserData else { return }
                let dataProvider = StatisticDataProvider()
                let viewModel = UserCardViewModel(dataProvider: dataProvider,
                                                  userData: actualUserData)
                let userCardViewController = UserCardViewController(viewModel)
                self?.tabBarController?.tabBar.isHidden = true
                self?.navigationController?.pushViewController(userCardViewController, animated: true)
            })
            .store(in: &bindings)
    }
    
    @objc
    private func tapOnFilter() {
        let controller = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        controller.addAction(.init(title: "По имени", style: .default) { [unowned viewModel] _ in
            viewModel.provideNameFilter()
        })
        controller.addAction(.init(title: "По рейтингу", style: .default) { [unowned viewModel] _ in
            viewModel.provideRatingFilter()
        })
        controller.addAction(.init(title: "Закрыть", style: .cancel))
        present(controller, animated: true)
    }
    
}

