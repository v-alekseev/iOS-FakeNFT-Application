//
//  UserDataProvider.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import Foundation

protocol StatisticDataProviderProtocol {
    func getUsersData( _ completion: @escaping (Result<[UserModel], Error>) -> Void)
    func getActualUserData(id: String, _ completion: @escaping (Result<UserModel, Error>) -> Void)
}

final class StatisticDataProvider: StatisticDataProviderProtocol {
    
    private var networkClient = DefaultNetworkClient()
    
    struct UsersRequest: NetworkRequest {
        var endpoint: URL? = URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/users")
    }
    
    struct ActualUserRequest: NetworkRequest {
        let userID: String
        var endpoint: URL? = nil
        init(userID: String) {
            self.userID = userID
            self.endpoint =  URL(string: "https://651ff0cc906e276284c3c1bc.mockapi.io/api/v1/users/\(userID)")
        }
    }
    
    func getUsersData( _ completion: @escaping (Result<[UserModel], Error>) -> Void) {
        let usersRequest = UsersRequest()
        networkClient.send(request: usersRequest, type: [UserModel].self) { [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        return
    }
    
    func getActualUserData(id: String, _ completion: @escaping (Result<UserModel, Error>) -> Void) {
        let actualUserRequest = ActualUserRequest(userID: id)
        networkClient.send(request: actualUserRequest, type: UserModel.self)  { [weak self] result in
            guard self != nil else { return }
            DispatchQueue.main.async {
                switch result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
        return
    }
}

