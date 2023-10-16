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

final class CartViewModel {
    
    weak var delegate: CartViewModelDelegate?
    var currentFilter: Filters.FilterClosure = Filters.filterDefault
    
    var cartDataProvider: CardDataProviderProtocol? {
        didSet {
            NotificationCenter.default.addObserver(self, 
                                                   selector: #selector(didCartChaged(_:)),
                                                   name: cartDataProvider?.orderChanged,
                                                   object: nil)
        }
    }
    
    private (set) var alertMessage: String = "" {
        didSet {
            if !alertMessage.isEmpty {
                delegate?.showAlert(message: alertMessage)
            }
        }
    }
    
    private (set) var order: [NftModel] = [] {
        didSet {
            delegate?.didUpdateCart()
        }
    }
    
    var totalPrice: Double  {
        get {
            var price: Double = 0
            
            for nft in order {
                price += nft.price
            }
            return price
        }
    }
    
    var cartNftIDs: [String] {
        get {
            order.map { $0.id }
        }
    }
    
    @objc func didCartChaged(_ notification: Notification) {
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
            case let .failure(error):
                self.alertMessage = L10n.Cart.getOrderError
                break
            default:
                break
            }
        }
    }
}
