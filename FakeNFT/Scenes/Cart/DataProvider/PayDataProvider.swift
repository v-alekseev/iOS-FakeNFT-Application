//
//  PayDataProvider.swift
//  FakeNFT
//
//  Created by Vitaly on 19.10.2023.
//

import Foundation

protocol PayDataProviderProtocol {
    func getCurrencies(_ completion: @escaping (Result<[CurrencyDto], Error>) -> Void)
    func payOrder(currencyId: String, _ completion: @escaping (Result<PaymentDto, Error>) -> Void)
}


struct CurrenciesRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/currencies")
}

struct PayRequest: NetworkRequest {
    // var httpMethod: HttpMethod { .put }
    // var dto: Encodable?
    var endpoint: URL? = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/orders/1")
    
    init(currencyIDs: String) {
        self.endpoint = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/orders/1/payment/\(currencyIDs)")
    }
}

final class PayDataProvider: PayDataProviderProtocol {

    
    
    //static var shared = CardDataProvider()
    
    var networkClient: NetworkClient
    
    let orderChanged = Notification.Name("CartUpdated")
    
    init(networkClient: NetworkClient = DefaultNetworkClient()) {
        self.networkClient = networkClient
    }
    
    func getCurrencies(_ completion: @escaping (Result<[CurrencyDto], Error>) -> Void) {
        let currenciesRequest = CurrenciesRequest()
        networkClient.send(request: currenciesRequest , type: [CurrencyDto].self)  { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    completion(.success(data))
                    print("getCurrencies success. Count = \(data.count)")
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        return
    }
    
    func payOrder(currencyId: String, _ completion: @escaping (Result<PaymentDto, Error>) -> Void) {
        let paymentReqest = PayRequest(currencyIDs: currencyId)
        networkClient.send(request: paymentReqest , type: PaymentDto.self)  { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        return
    }
    
}
