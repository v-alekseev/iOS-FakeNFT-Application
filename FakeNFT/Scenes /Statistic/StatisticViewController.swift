//
//  StatisticViewController.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import UIKit
import Combine

final class StatisticViewController: UIViewController {
    
    private lazy var tableView = createTableView()
    private lazy var loadIndicator = createActivityIndicator()
    private let viewModel: StatisticViewModel
    private var subscribes = [AnyCancellable]()
    
    init(_ viewModel: StatisticViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.$usersData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                
                if self?.viewModel.dataLoad == true {
                    self?.loadIndicator.startAnimating()
                } else {
                    self?.loadIndicator.stopAnimating()
                }
                
                self?.tableView.reloadData()})
            .store(in: &subscribes)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        
        view.backgroundColor = .ypWhiteWithDarkMode
        
        let filterButton = UIBarButtonItem(image: UIImage(named: "filterButton"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(tapOnFilter))
        filterButton.tintColor = .ypBlackWithDarkMode
        navigationItem.rightBarButtonItem  = filterButton
        
        view.addSubview(tableView)
        view.addSubview(loadIndicator)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            loadIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            loadIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.register(StatisticCell.self)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
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

extension StatisticViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            viewModel.usersData.count
        default:
            0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StatisticCell.defaultReuseIdentifier,
            for: indexPath) as? StatisticCell
        cell?.provide(userData: viewModel.usersData[indexPath.row])
        return cell ?? StatisticCell()
    }
}

extension StatisticViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dataProvider = StatisticDataProvider()
        let viewModel = UserCartViewModel(dataProvider: dataProvider,
                                          userID: viewModel.usersData[indexPath.row].id)
        let userCardViewController = UserCardViewController(viewModel)
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(userCardViewController, animated: true)
        
    }
    
}
