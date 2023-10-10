//
//  CardDataProvider.swift
//  FakeNFT
//
//  Created by Vitaly on 10.10.2023.
//

import Foundation

protocol CardDataProviderProtocol {
    func getOrder()
    func getNFT(id: String, _ completion: @escaping (Result<NFTModel, Error>) -> Void)
    func getCurrencies()
    func getCurrency(id: Int)
    func paymentOrder()
    
    
}

struct OrderRequest: NetworkRequest {
    var endpoint: URL? = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/orders/1")
}


struct NFSRequest: NetworkRequest {
    let nfsID: String
    var endpoint: URL? = nil
    init(nfsID: String) {
        self.nfsID = nfsID
        self.endpoint =  URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/nft/\(nfsID)")
    }
}


final class CardDataProvider: CardDataProviderProtocol {
    
    private var networkClient = DefaultNetworkClient()
    var orderIDs: [String] = []
    var order: [NFTModel] = [] {
        didSet {
            if orderIDs.count == order.count {
                print("[download completed]")
            }
        }
    }
    
    func getOrder() {
        
        let orderRequest = OrderRequest()
        self.orderIDs.removeAll()
        
        networkClient.send(request: orderRequest , type: OrderModel.self)  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                print("nfts: \(data.nfts)")
                print("id: \(data.id)")
                self.orderIDs.append(contentsOf: data.nfts)
                print("[result] orderIDs = \(self.orderIDs)")
                
                self.order.removeAll()
                for nftID in data.nfts {
                    getNFT(id: nftID) { [weak self] result in
                        guard let self = self else { return }
                        switch result {
                        case let .success(ntf):
                            print(ntf)
                            self.order.append(ntf)
                        case let .failure(error):
                            print(error)
                        }
                    }
                }

            case let .failure(error):
                print(error)
            }
        }
        return
    }
    
    func getNFT(id: String, _ completion: @escaping (Result<NFTModel, Error>) -> Void) {
        let ntfsRequest = NFSRequest(nfsID: id)
        networkClient.send(request: ntfsRequest , type: NFTModel.self)  { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(data):
                //print(data)
                //self.order.append(data)
                completion(.success(data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        return
    }
    
    func getCurrencies() {
        return
    }
    
    func getCurrency(id: Int) {
        return
    }
    
    func paymentOrder() {
        return
    }
    
    
}
