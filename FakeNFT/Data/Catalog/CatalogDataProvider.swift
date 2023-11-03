//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 10.10.2023.
//

import Foundation

final class CatalogDataProvider: CatalogDataProviderProtocol {
    
    private let client: NetworkClient
    private var currentTask: NetworkTask?
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    func fetchMeLikes(completion: @escaping (Result<ProfileLikesModel, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async{
            let getLikesRequest = DefaultNetworkRequest(
                endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/profile/1")!,
                httpMethod: .get
            )
            self.client.send(request: getLikesRequest, type: ProfileLikesModel.self) { result in
                completion(result)
            }
        }
    }
    
    func fetchMeOrders(completion: @escaping (Result<OrderModel, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async{
            let getOrdersRequest = DefaultNetworkRequest(
                endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/orders/1")!,
                httpMethod: .get
            )
            self.client.send(request: getOrdersRequest, type: OrderModel.self) { result in
                completion(result)
            }
        }
    }
    
    func setLikes(likes: [String], completion: @escaping (Result<ProfileLikesModel, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async{
            let postLikesRequest = DefaultNetworkRequest(
                endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/profile/1")!,
                httpMethod: .put,
                dto: ProfileLikesModel(likes: likes)
            )
            self.client.send(request: postLikesRequest, type: ProfileLikesModel.self) { result in
                completion(result)
            }
        }
    }
    
    func setOrders(orders: OrderModel, completion: @escaping (Result<OrderModel, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async{
            let postOrdersRequest = DefaultNetworkRequest(
                endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/orders/1")!,
                httpMethod: .put,
                dto: orders
            )
            self.client.send(request: postOrdersRequest, type: OrderModel.self) { result in
                completion(result)
            }
        }
    }
    
    func fetchMeAllCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let getCollectionsRequest = DefaultNetworkRequest(
                endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/collections")!,
                httpMethod: .get
            )
            
            self.currentTask = self.client.send(request: getCollectionsRequest, type: [CollectionModel].self) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }
    
    func fetchMyAuthor(with id: String, completion: @escaping (Result<AuthorModel, Error>) -> Void) {
        let getAuthorRequest = DefaultNetworkRequest(
            endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/users/\(id)")!,
            httpMethod: .get
        )
        currentTask = self.client.send(request: getAuthorRequest, type: AuthorModel.self) { result in
            completion(result)
        }
    }
    
    func fetchMeNft(withID id: String, completion: @escaping (Result<NFTModel, Error>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let getNFTRequest = DefaultNetworkRequest(
                endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/nft/\(id)")!,
                httpMethod: .get
            )
            self.client.send(request: getNFTRequest, type: NFTModel.self) { result in
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }
    }

    
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}
