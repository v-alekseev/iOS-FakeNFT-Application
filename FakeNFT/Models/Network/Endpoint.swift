protocol Endpoint {
    associatedtype ResponseType: Decodable
    var path: String { get }   
    func asNetworkRequest() -> NetworkRequest
}
