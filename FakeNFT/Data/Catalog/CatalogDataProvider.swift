import Foundation

final class CatalogDataProvider {
    private let client: NetworkClient
    private var currentTask: NetworkTask?
//    private var likes: [String]?
    
    init(client: NetworkClient = DefaultNetworkClient()) {
        self.client = client
//        let endpoint = AllLikesEndPoint()
//        self.fetchData(using: endpoint) { result in
//            switch result {
//            case .success(let data):
//                self.likes = data.likes
//            case .failure(let error):
//                print(error)
//                return
//            }
//        }
    }
    
    func interactWithLikeForNft(id: String, completion: @escaping () -> Void) {
        let likesEndpoint = AllLikesEndPoint()
        self.fetchData(using: likesEndpoint) { result in
            switch result {
            case .success(let data):
                var newLikes = data.likes
                if newLikes.contains(id) {
                    newLikes.removeAll(where: { $0 == id })
                } else {
                    newLikes.append(id)
                }
                let postpoint = PostLikesEndpoint()
                print("НОВЫЙ НАБОР ЛАЙКОВ \(newLikes)")
                print("dto: \(PostLikesEndpoint.ResponseType(likes: newLikes)))")
  
                self.fetchData(using: postpoint,
                               dto: PostLikesEndpoint.ResponseType(likes: newLikes)) {result in
                    switch result {
                    case .success(let data):
                        print("OK")
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                completion()
            case .failure(let error):
                print(error)
                return
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
