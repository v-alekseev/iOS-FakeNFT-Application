//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 08.10.2023.
//


import Foundation
struct SingleCollectionEndpoint: Endpoint {
    typealias ResponseType = CollectionModel
    
    var path = "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/collections"
    
    init (id: Int) {
        self.path = path + "/" + String(id)
    }
    
    func asNetworkRequest(dto: CollectionModel?) -> NetworkRequest {
        return DefaultNetworkRequest(endpoint: URL(string: path)!)
    }
}
