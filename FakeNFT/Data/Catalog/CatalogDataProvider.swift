import Foundation

final class CatalogDataProvider {
    private let client: NetworkClient
    private var currentTask: NetworkTask?
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
    }
    
    func giveMeAllLikes() -> ProfileLikesModel? {
        let dispatchGroup = DispatchGroup()
        let ep = AllLikesEndPoint()
        var model: ProfileLikesModel? = nil
        dispatchGroup.enter()
        self .fetchData(using: ep) { result in
            print("fetching...")
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
        let ep = PostLikesEndpoint()
        var model: ProfileLikesModel? = ProfileLikesModel(likes: likes)
        dispatchGroup.enter()
        self.fetchData(using: ep, dto: model) { result in
            switch result {
            case .success(let data):
                model = data
            case .failure:
                model = nil
            }
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
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
