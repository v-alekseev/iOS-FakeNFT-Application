//
//  UserDataProvider.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import Foundation

protocol StatisticDataProviderProtocol {
    func getUsersData( _ completion: @escaping (Result<[UserModel], Error>) -> Void)
    func getNftWithId(nftId: String, _ completion: @escaping (Result<NftModel, Error>) -> Void)
    func getProfileLikes( _ completion: @escaping (Result<ProfileLikesModel, Error>) -> Void)
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
    
    func getNftWithId(nftId: String, _ completion: @escaping (Result<NftModel, Error>) -> Void) {
        let usersRequest = NftWithIdRequest(nftID: nftId)
        networkClient.send(request: usersRequest, type: NftModel.self) { [weak self] result in
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
    
    func getProfileLikes( _ completion: @escaping (Result<ProfileLikesModel, Error>) -> Void) {
        let profileRequest = ProfileRequest()
        networkClient.send(request: profileRequest, type: ProfileLikesModel.self) { [weak self] result in
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

