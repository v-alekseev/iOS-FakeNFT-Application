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
    private let viewModel = StatisticViewModel(userDataProvider: UserDataProviderImpl())
    private var subscribes = [AnyCancellable]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.$userData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] _ in
                self?.tableView.reloadData()})
            .store(in: &subscribes)
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
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
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

    @objc
    private func tapOnFilter() {
        let controller = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        controller.addAction(.init(title: "По имени", style: .default) { [weak self] _ in
            self?.viewModel.provideNameFilter()
        })
        controller.addAction(.init(title: "По рейтингу", style: .default) { [weak self] _ in
            self?.viewModel.provideRatingFilter()
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
            viewModel.userData.count
        default:
            0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StatisticCell.defaultReuseIdentifier,
            for: indexPath) as? StatisticCell
        cell?.provide(userData: viewModel.userData[indexPath.row])
        return cell ?? StatisticCell()
    }
}

extension StatisticViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let userCardViewController = UserCardViewController()
        tabBarController?.tabBar.isHidden = true
        navigationController?.pushViewController(userCardViewController, animated: true)

    }

}
