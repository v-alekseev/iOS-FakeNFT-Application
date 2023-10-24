//
//  CartViewModel.swift
//  FakeNFT
//
//  Created by Vitaly on 10.10.2023.
//

import Foundation

protocol CartViewModelDelegate: AnyObject {
    func didUpdateCart()
    func showAlert(message: String)
    func hideCartEvent(hide: Bool)
    func willUpdateCart()
}

protocol CartViewModelProtocol {
    var delegate: CartViewModelDelegate? {get set}
    var cartDataProvider: CardDataProviderProtocol? {get}
    var order: [NftModel]  {get}
    var totalPrice: Double {get}
    
    func filterCart(_ filter: Filters.filterBy)
    func getOrder()
}

final class CartViewModel: CartViewModelProtocol {
    // MARK: - Properties
    //
    weak var delegate: CartViewModelDelegate?
    
    private (set) var cartDataProvider: CardDataProviderProtocol?
    
    var totalPrice: Double  {
        get {
            var price: Double = 0
            
            for nft in order {
                price += nft.price
            }
            return price
        }
    }

    private (set) var order: [NftModel] = [] {
        didSet {
            delegate?.didUpdateCart()
            delegate?.hideCartEvent(hide: order.count == 0)
        }
    }
    
    private var alertMessage: String = "" {
        didSet {
            if !alertMessage.isEmpty {
                delegate?.showAlert(message: alertMessage)
            }
        }
    }
    
    private var storage: UserDefaults = .standard
    private let userDateFilterKey = "current_filter"
    private var currentFilter: Filters.filterBy {
        get {
            let filterID = storage.integer(forKey: userDateFilterKey) // переписываем чтение
            return  Filters.filterBy(rawValue: filterID) ?? .id // .id - default sort
        }
        set {
            storage.setValue(newValue.rawValue, forKey: userDateFilterKey)
        }
    }
      
    // MARK: - init
    //

    init(dataProvider: CardDataProviderProtocol? = CardDataProvider.shared) {
        self.cartDataProvider = dataProvider
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCartChaged(_:)),
                                               name: self.cartDataProvider?.orderChanged,
                                               object: nil)
    }
    
    // MARK: - Actions
    //
    @objc private func didCartChaged(_ notification: Notification) {
        guard let cartDataProvider = cartDataProvider  else {return}
        
        let orderUnsorted = cartDataProvider.order.compactMap{NftModel(nft: $0)}
        order = orderUnsorted.sorted(by: Filters.filter[currentFilter] ?? Filters.filterDefault )
    }
    
    // MARK: - Public functions
    //
    func filterCart(_ filter: Filters.filterBy) {
        currentFilter = filter
        order = order.sorted(by: Filters.filter[currentFilter] ?? Filters.filterDefault )
    }
    
    func getOrder() {
        delegate?.willUpdateCart()
        cartDataProvider?.getOrder() { [weak self] result in
            guard let self = self else { return }
            switch result {
                //case .success(_) - это значение не возвращается и никаких действий делать не надо  т.к. по окончанию загрузки придет нотификация
            case .failure(_):
                self.delegate?.didUpdateCart()
                self.alertMessage = L10n.Cart.getOrderError
                break
            default:
                break
            }
        }
    }
}
