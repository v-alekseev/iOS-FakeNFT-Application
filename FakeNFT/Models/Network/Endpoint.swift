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

