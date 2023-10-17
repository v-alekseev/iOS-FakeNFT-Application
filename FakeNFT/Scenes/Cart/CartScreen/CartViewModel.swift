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
}

protocol CartViewModelProtocol {
    var delegate: CartViewModelDelegate? {get set}
    var cartDataProvider: CardDataProviderProtocol? {get}
    var order: [NftModel]  {get}
    var totalPrice: Double {get}
    
    func filterCart(_ filter: @escaping Filters.FilterClosure)
    func getOrder()
}

final class CartViewModel: CartViewModelProtocol {
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
        }
    }
    
    private var alertMessage: String = "" {
        didSet {
            if !alertMessage.isEmpty {
                delegate?.showAlert(message: alertMessage)
            }
        }
    }
    
    private var currentFilter: Filters.FilterClosure = Filters.filterDefault
    
    init(dataProvider: CardDataProviderProtocol? = CardDataProvider.shared) {
        self.cartDataProvider = dataProvider
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didCartChaged(_:)),
                                               name: self.cartDataProvider?.orderChanged,
                                               object: nil)
    }
    
    @objc private func didCartChaged(_ notification: Notification) {
        guard let cartDataProvider = cartDataProvider  else {return}
        
        let orderUnsorted = cartDataProvider.order.compactMap{NftModel(nft: $0)}
        order = orderUnsorted.sorted(by: currentFilter)
    }
    
    func filterCart(_ filter: @escaping Filters.FilterClosure) {
        currentFilter = filter
        order = order.sorted(by: currentFilter)
    }
    
    func getOrder() {
        cartDataProvider?.getOrder() { [weak self] result in
            guard let self = self else { return }
            switch result {
                //case .success(_) - это значение не возвращается и никаких действий делать не надо  т.к. по окончанию загрузки придет нотификация
            case .failure(_):
                self.alertMessage = L10n.Cart.getOrderError
                break
            default:
                break
            }
        }
    }
}
