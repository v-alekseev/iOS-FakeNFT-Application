import Foundation
import UIKit

final class CollectionsViewController: UIViewController {
    private let viewModel: CollectionsViewModelProtocol = CollectionsViewModel()
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
    }
}
