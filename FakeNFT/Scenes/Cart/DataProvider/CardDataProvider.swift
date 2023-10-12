//
//  CardDataProvider.swift
//  FakeNFT
//
//  Created by Vitaly on 10.10.2023.
//

import Foundation

protocol CardDataProviderProtocol {
    func getOrder(_ completion: @escaping (Result<String, Error>) -> Void)
    func getNFT(id: String, _ completion: @escaping (Result<NftDto, Error>) -> Void)
    func getCurrencies()
    func getCurrency(id: Int)
    func paymentOrder()
    func updateCart(ids: [String],  _ completion: @escaping (Result<[String], Error>) -> Void)
    
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

struct cartUpdateRequest: NetworkRequest {
    var httpMethod: HttpMethod { .put }
    var dto: Encodable?
    var endpoint: URL? = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/orders/1")
    
    init(cartIDs: [String]) {
        self.dto = UpdateCartDto(nfts: cartIDs)
    }
}


protocol CardDataProviderDelegate: AnyObject {
    /// событие вызывается когда в переменную order и orderIDs загружены данные
    func cartLoaded()
    /// событие вызывается когда данные в корзине изменеились. При этом переменные order и orderIDs содержат старые данные
    //func cartUpded()
}

final class CardDataProvider: CardDataProviderProtocol {
    
    private var networkClient = DefaultNetworkClient()
    weak var delegate: CardDataProviderDelegate?
    
    var orderIDs: [String] = []
    var order: [NftDto] = [] {
        didSet {
            // если колличество загруженных nft равняется колличеству nftid, значит все запросы отработали и можно перегрузить отображать корзину
            if orderIDs.count == order.count {
                delegate?.cartLoaded()
            }
        }
    }
    
    func getOrder(_ completion: @escaping (Result<String, Error>) -> Void) {
        let orderRequest = OrderRequest()
        self.orderIDs.removeAll()
        
        networkClient.send(request: orderRequest , type: OrderDto.self)  { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case let .success(data):
                    self.orderIDs.append(contentsOf: data.nfts)
                    self.order.removeAll()
                    for nftID in data.nfts {
                        getNFT(id: nftID) { [weak self] result in
                            guard let self = self else { return }
                            switch result {
                            case let .success(ntf):
                                self.order.append(ntf)
                            case let .failure(error):
                                print(error)
                                completion(.failure(error))
                            }
                        }
                    }
                    
                case let .failure(error):
                    print(error)
                    completion(.failure(error))
                }
            }
        }
        return
    }
    
    func getNFT(id: String, _ completion: @escaping (Result<NftDto, Error>) -> Void) {
        let ntfsRequest = NFSRequest(nfsID: id)
        networkClient.send(request: ntfsRequest , type: NftDto.self)  { result in
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
    
    func updateCart(ids: [String],  _ completion: @escaping (Result<[String], Error>) -> Void) {
        
        let ntfsRequest = cartUpdateRequest(cartIDs: ids)
        networkClient.send(request: ntfsRequest , type: UpdateCartDto.self)  { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    completion(.success(data.nfts))
                case let .failure(error):
                    completion(.failure(error))
                }
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
