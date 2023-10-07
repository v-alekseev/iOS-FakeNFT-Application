import Foundation

struct AllCollectionsEndpoint: Endpoint {
    typealias ResponseType = [CollectionModel]
    var path = "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/collections"
    
    func asNetworkRequest() -> NetworkRequest {
        return DefaultNetworkRequest(endpoint: URL(string: path)!)
    }
}
