//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 08.10.2023.
//

protocol Endpoint {
    associatedtype ResponseType: Decodable
    var path: String { get }
    func asNetworkRequest(dto: ResponseType?) -> NetworkRequest
}

extension Endpoint {
    func asNetworkRequest() -> NetworkRequest {
        return asNetworkRequest(dto: nil)
    }
}

