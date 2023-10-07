import Foundation

class CatalogDataRepository {
    
    private let client: NetworkClient
    private var currentTask: NetworkTask?
    
    init(client: NetworkClient = DefaultNetworkClient()) {
            self.client = client
        }
    
    func giveMeData<T: Endpoint>(
        using endpoint: T,
        completion: @escaping (Result<T.ResponseType, Error>) -> Void
    ) {
        fetchData(using: endpoint, completion: completion)
    }
    

    private func fetchData<T: Endpoint>(
        using endpoint: T,
        completion: @escaping (Result<T.ResponseType, Error>) -> Void
    ) {
        cancelCurrentTask()
        let request = endpoint.asNetworkRequest()
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
