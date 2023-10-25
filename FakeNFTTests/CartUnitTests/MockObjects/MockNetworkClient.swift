//
//  MockNetworkClient.swift
//  FakeNFTTests
//
//  Created by Vitaly on 21.10.2023.
//

import Foundation
@testable import FakeNFT
import XCTest


struct MockNetworkTask: NetworkTask {
    func cancel() {
    }
}

class MockNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }
    
    
    var cardResponce  =  """
{"nfts":["93","94"],"id":"1"}
"""
    var nfs93Responce =  """
{"createdAt":"2023-04-20T02:22:27Z","name":"Bitsy","images":["https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Rosie/1.png"],"rating":2,"description":"A digital painting of a colorful flower garden","price":6.59,"author":"30","id":"93"}
"""
    var nfs94Responce =  """
{"createdAt":"2023-04-20T02:22:27Z","name":"Bitsy","images":["https://code.s3.yandex.net/Mobile/iOS/NFT/Brown/Bitsy/1.png"],"rating":2,"description":"A digital sculpture of a dragon breathing fire","price":3.45,"author":"30","id":"89"}
"""
    
    func send(request: FakeNFT.NetworkRequest, onResponse: @escaping (Result<Data, Error>) -> Void) -> FakeNFT.NetworkTask? {
        // не используется в тестах
        return MockNetworkTask()
    }
    
    func send<T: Decodable>(request: NetworkRequest, type: T.Type, onResponse: @escaping (Result<T, Error>) -> Void) -> NetworkTask? {
        
        var data = Data()
        if( request.endpoint?.absoluteString == "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/orders/1") {
            data = Data(cardResponce.utf8)
        }
        
        if( request.endpoint?.absoluteString == "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/nft/93") {
            data = Data(nfs93Responce.utf8)
        }
        if( request.endpoint?.absoluteString == "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/nft/94") {
            data = Data(nfs94Responce.utf8)
        }
        
        self.parse(data: data, type: type, onResponse: onResponse)
        
        return MockNetworkTask()
    }
    
    private func parse<T: Decodable>(data: Data, type _: T.Type, onResponse: @escaping (Result<T, Error>) -> Void) {
        do {
            let response = try decoder.decode(T.self, from: data)
            onResponse(.success(response))
        } catch {
            onResponse(.failure(NetworkClientError.parsingError))
        }
    }
    
    
}

