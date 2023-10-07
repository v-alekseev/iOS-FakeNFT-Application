import Foundation

class CatalogDataRepository {
    
    private let client: NetworkClient
    private var currentTask: NetworkTask?
    
    init(client: NetworkClient = DefaultNetworkClient()) {
            self.client = client
        }
    
    func giveMeAllCollections() -> [CollectionModel]? {
        var c: [CollectionModel]?
        fetchCollections() {result in
            switch result {
            case .success(let collections):
                c = collections
            case .failure(_):
                c =  nil
            }
        }
        return c
    }
    
    func giveMeCollection(id: Int) -> CollectionModel? {
        var c: CollectionModel?
        fetchCollection(id: id) {result in
            switch result {
            case .success(let collection):
                c = collection
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
    
    func cancelCurrentTask() {
        currentTask?.cancel()
    }
}
