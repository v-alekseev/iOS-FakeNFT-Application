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
    
    func giveMeAllLikes() -> ProfileLikesModel? {
        let dispatchGroup = DispatchGroup()
        let getLikesRequest = DefaultNetworkRequest(
            endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/profile/1")!,
            httpMethod: .get
        )
        var model: ProfileLikesModel? = nil
        dispatchGroup.enter()
        currentTask = self.client.send(request: getLikesRequest, type: ProfileLikesModel.self) { result in
            switch result {
            case .success(let data):
                model = data
            case .failure:
                model = nil
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        return model
    }
    
    func setLikes(likes: [String]) {
        let dispatchGroup = DispatchGroup()
        let postLikesRequest = DefaultNetworkRequest(
            endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/profile/1")!,
            httpMethod: .put,
            dto: ProfileLikesModel(likes: likes)
        )
        dispatchGroup.enter()
        currentTask = self.client.send(request: postLikesRequest, type: ProfileLikesModel.self) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure: break
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
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
    
    func giveMeCollection(withID id: String) -> CollectionModel? {
        let dispatchGroup = DispatchGroup()
        let getCollectionRequest = DefaultNetworkRequest(
            endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/collections/\(id)")!,
            httpMethod: .get
        )
        var model: CollectionModel? = nil
        dispatchGroup.enter()
        currentTask = self.client.send(request: getCollectionRequest, type: CollectionModel.self) { result in
            switch result {
            case .success(let data):
                model = data
            case .failure:
                model = nil
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        return model
    }
    
    func giveMeAllNFTs() -> [NFTModel] {
        let dispatchGroup = DispatchGroup()
        let getNFTsRequest = DefaultNetworkRequest(
            endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/nft")!,
            httpMethod: .get
        )
        var model: [NFTModel] = []
        dispatchGroup.enter()
        currentTask = self.client.send(request: getNFTsRequest, type: [NFTModel].self) { result in
            switch result {
            case .success(let data):
                print("КАВАБАНГА")
                model = data
            case .failure (let error):
                print(error.localizedDescription)
                print(error)
                model = []
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        return model
    }
    
//    func giveMeNft(withID id: String) -> NFTModel? {
//        let dispatchGroup = DispatchGroup()
//        let getNFTRequest = DefaultNetworkRequest(
//            endpoint: URL(string: "\(mockAPIEndpoint)/api/v1/nft/\(id)")!,
//            httpMethod: .get
//        )
//        var model: NFTModel? = nil
//        dispatchGroup.enter()
//        currentTask = self.client.send(request: getNFTRequest, type: NFTModel.self) { result in
//            switch result {
//            case .success(let data):
//                model = data
//            case .failure:
//                model = nil
//            }
//            dispatchGroup.leave()
//        }
//        dispatchGroup.wait()
//        return model
//    }
    
    func giveMeNft(withID id: String, completion: @escaping (Result<NFTModel, Error>) -> Void) {
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
    
    func giveMeData<T: Endpoint>(
        using endpoint: T,
        completion: @escaping (Result<T.ResponseType, Error>) -> Void
    ) {
        fetchData(using: endpoint, completion: completion)
    }
    

    private func fetchData<T: Endpoint>(
        using endpoint: T,
        dto: T.ResponseType? = nil,
        completion: @escaping (Result<T.ResponseType, Error>) -> Void
    ) {
        cancelCurrentTask()
        let request = endpoint.asNetworkRequest(dto:dto)
        print(request)
        currentTask = client.send(request: request, type: T.ResponseType.self) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}
