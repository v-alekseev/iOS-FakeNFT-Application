import Foundation

class CatalogDataRepository {
    
    private let client: NetworkClient
    private var currentTask: NetworkTask?
    
    init(client: NetworkClient = DefaultNetworkClient()) {
            self.client = client
        }
    
    func giveMeAllCollections(
         completion: @escaping ([CollectionModel]?)->Void = {_ in }
    ) -> [CollectionModel]? {
        var c: [CollectionModel]?
        fetchCollections() {result in
            switch result {
            case .success(let collections):
                c = collections
                completion(c)
            case .failure(_):
                c =  nil
            }
        }
        return c
    }
    
    func giveMeCollection(
        id: Int,
        completion: @escaping (CollectionModel?)->Void = {_ in }
    ) -> CollectionModel? {
        var c: CollectionModel?
        fetchCollection(id: id) {result in
            switch result {
            case .success(let collection):
                c = collection
                completion(c)
            case .failure(_):
                c =  nil
            }
        }
        return c
    }
    
    func giveMeAllNFTs(
        completion: @escaping ([NFTModel]?)->Void = {_ in }
    ) -> [NFTModel]? {
        var c: [NFTModel]?
        fetchNFTs() {result in
            switch result {
            case .success(let nfts):
                c = nfts
                completion(c)
            case .failure(_):
                c =  nil
            }
        }
        return c
    }
    
    func giveMeNFT(
        id: Int,
        completion: @escaping (NFTModel?)->Void = {_ in }
    ) -> NFTModel? {
        var c: NFTModel?
        fetchNFT(id: id) {result in
            switch result {
            case .success(let nft):
                c = nft
                completion(c)
            case .failure(_):
                c =  nil
            }
        }
        return c
    }
    
    
    private func fetchCollection(id: Int, completion: @escaping (Result<CollectionModel, Error>) -> Void) {
        cancelCurrentTask()
        let request = CollectionsRequest(id: id)

        currentTask = client.send(request: request, type: CollectionModel.self) { result in
            switch result {
            case .success(let collections):
                completion(.success(collections))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void) {
        cancelCurrentTask()
        let request = CollectionsRequest()
        currentTask = client.send(request: request, type: [CollectionModel].self) { result in
            switch result {
            case .success(let collections):
                completion(.success(collections))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchNFTs(completion: @escaping (Result<[NFTModel], Error>) -> Void) {
        cancelCurrentTask()
        let request = NFTsRequest()
        currentTask = client.send(request: request, type: [NFTModel].self) { result in
            switch result {
            case .success(let nfts):
                completion(.success(nfts))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetchNFT(id: Int, completion: @escaping (Result<NFTModel, Error>) -> Void) {
        cancelCurrentTask()
        let request = NFTsRequest(id: id)
        currentTask = client.send(request: request, type: NFTModel.self) { result in
            switch result {
            case .success(let nft):
                completion(.success(nft))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}
