import Foundation

class CatalogDataRepository {

    let client = DefaultNetworkClient()
    private var currentTask: NetworkTask?
    
    func fetchCollections(completion: @escaping (Result<[CollectionModel], Error>) -> Void) {
        
        currentTask?.cancel()
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
