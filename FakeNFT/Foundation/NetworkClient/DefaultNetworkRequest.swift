import Foundation

struct DefaultNetworkRequest: NetworkRequest {
    var endpoint: URL?
    var httpMethod: HttpMethod
    var dto: Encodable?

    init(endpoint: URL, httpMethod: HttpMethod = .get, dto: Encodable? = nil) {
        self.endpoint = endpoint
        self.httpMethod = httpMethod
        self.dto = dto
    }
}
