//
//  StatisticView.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 17.10.2023.
//

import UIKit
import Combine

final class StatisticView: UIView {
    
    @Published var didRefreshTable = false
    
    var isLoading: Bool = false {
            didSet { isLoading ? loadIndicator.startAnimating() : loadIndicator.stopAnimating() }
        }
    
    private var usersData: [UserModel] = []
    private lazy var tableView = createTableView()
    private lazy var loadIndicator = createActivityIndicator()
    
    init() {
        super.init(frame: .zero)

        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        
        backgroundColor = .ypWhiteWithDarkMode
        
        [tableView, loadIndicator].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            loadIndicator.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            loadIndicator.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(StatisticCell.self)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        return tableView
    }
    
    private func createActivityIndicator() -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }
    
    @objc func refreshTable() {
        didRefreshTable = true
    }
    
}

extension StatisticView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: StatisticCell.defaultReuseIdentifier,
            for: indexPath) as? StatisticCell
        cell?.provide(userData: usersData[indexPath.row])
        return cell ?? StatisticCell()
    }
}

extension StatisticView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        88
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

