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
    
    private let networkClient = DefaultNetworkClient()
    
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

