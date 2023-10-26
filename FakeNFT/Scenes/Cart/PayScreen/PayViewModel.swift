//
//  PayViewModel.swift
//  FakeNFT
//
//  Created by Vitaly on 19.10.2023.
//

import Foundation
typealias Currency = CurrencyDto

protocol PayViewModelDelegate: AnyObject {
    func willUpdateCurrensies()
    func didUpdateCurrensies()
    func didSelectCurrency()
    func willDoPayment()
    func didPayment(result: Bool)
}

protocol PayViewModelProtocol {
    var delegate: PayViewModelDelegate? {get set}
    var currencies: [Currency] {get}
    var selectedCurrency: Currency? {get set}

    func getCurrensies()
    func payOrder()
}

final class PayViewModel: PayViewModelProtocol {
    
    weak var delegate: PayViewModelDelegate?
    private (set) var payDataProvider: PayDataProviderProtocol?
    private (set) var cartDataProvider: CardDataProviderProtocol?
    private (set) var currencies: [Currency] = []
    
    var selectedCurrency: Currency? {
        didSet {
            if selectedCurrency != nil {
                delegate?.didSelectCurrency()
            }
        }
    }
    
    init(payDataProvider: PayDataProviderProtocol? = PayDataProvider(), cartDataProvider: CardDataProviderProtocol? = CardDataProvider.shared) {
        self.payDataProvider = payDataProvider
        self.cartDataProvider = cartDataProvider
    }
    
    func getCurrensies() {
        delegate?.willUpdateCurrensies()
        payDataProvider?.getCurrencies() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                self.currencies = data.compactMap( { Currency($0) })   // конечно можно написать просто   self.currencies = data, но так как-то "правильнее" 
                delegate?.didUpdateCurrensies()
            case let .failure(error):
                print("getCurrencies error: \(error)")
            }
        }
    }

    func payOrder() {
        guard let selectedCurrency = self.selectedCurrency else { return }
        delegate?.willDoPayment()
        payDataProvider?.payOrder(currencyId: selectedCurrency.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                if(data.success) {
                    clearCart()
                }
                delegate?.didPayment(result: data.success)
            case .failure(_):
                delegate?.didPayment(result: false)
            }
        }
    }
    
    func clearCart() {
        cartDataProvider?.removeAllItemFromCart() { result in
            switch result {
            case let .success(data):
                print("[clearCart] success. Count items in cart = \(data)")
                break
            case .failure(_):
                print("[clearCart] failed")
                break
            }
        }
    }
}
