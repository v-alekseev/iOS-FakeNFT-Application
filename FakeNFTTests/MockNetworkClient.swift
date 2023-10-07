@testable import FakeNFT
import XCTest

class MockNetworkClient: NetworkClient {
    var mockData: Data?
    var mockError: Error?
    
    func send(request: NetworkRequest, onResponse: @escaping (Result<Data, Error>) -> Void) -> NetworkTask? {
        if let mockData = mockData {
            onResponse(.success(mockData))
        } else if let mockError = mockError {
            onResponse(.failure(mockError))
        }
        return nil
    }

    func send<T: Decodable>(request: NetworkRequest, type: T.Type, onResponse: @escaping (Result<T, Error>) -> Void) -> NetworkTask? {
        if let mockData = mockData {
            do {
                let decoded = try JSONDecoder().decode(T.self, from: mockData)
                onResponse(.success(decoded))
            } catch {
                onResponse(.failure(error))
            }
        } else if let mockError = mockError {
            onResponse(.failure(mockError))
        }
        return nil
    }
}

