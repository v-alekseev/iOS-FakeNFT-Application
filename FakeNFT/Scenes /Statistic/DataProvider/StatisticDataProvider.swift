//
//  UserDataProvider.swift
//  FakeNFT
//
//  Created by Александр Пичугин on 08.10.2023.
//

import Foundation

protocol StatisticDataProviderProtocol {
    func getUsersData( _ completion: @escaping (Result<[UserModel], Error>) -> Void)
    func getArrayOfNftsWithID(arrayOfId: [String], _ completion: @escaping (Result<[NftModel], Error>) -> Void)
    
 //   func getActualUserData(id: String, _ completion: @escaping (Result<UserModel, Error>) -> Void)
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
    
    func getArrayOfNftsWithID(arrayOfId: [String], _ completion: @escaping (Result<[NftModel], Error>) -> Void) {
        let mock: [NftModel] = [NftModel(name: "AAArg",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                         rating: 1,
                                         price: 0.434304,
                                         id: "1"),
                                NftModel(name: "Archie",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                         rating: 2,
                                         price: 9,
                                         id: "2"),
                                NftModel(name: "Ccc",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                         rating: 3,
                                         price: 8,
                                         id: "3"),
                                NftModel(name: "Ddd",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Biscuit/1.png"],
                                         rating: 4,
                                         price: 7,
                                         id: "4"),
                                NftModel(name: "Eee",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Breena/1.png"],
                                         rating: 5,
                                         price: 6,
                                         id: "5"),
                                NftModel(name: "Fff",
                                         imageURL: [""],
                                         rating: 1,
                                         price: 5,
                                         id: "6"),
                                NftModel(name: "AAA",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                         rating: 1,
                                         price: 10,
                                         id: "7"),
                                NftModel(name: "BBB",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                         rating: 2,
                                         price: 9,
                                         id: "8"),
                                NftModel(name: "Ccc",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                         rating: 3,
                                         price: 8,
                                         id: "9"),
                                NftModel(name: "AAA",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                         rating: 1,
                                         price: 10,
                                         id: "10"),
                                NftModel(name: "BBB",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                         rating: 2,
                                         price: 9,
                                         id: "11"),
                                NftModel(name: "Ccc",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                         rating: 3,
                                         price: 8,
                                         id: "12"),
                                NftModel(name: "Ddd",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Biscuit/1.png"],
                                         rating: 4,
                                         price: 7,
                                         id: "13"),
                                NftModel(name: "Eee",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Breena/1.png"],
                                         rating: 5,
                                         price: 6,
                                         id: "14"),
                                NftModel(name: "Fff",
                                         imageURL: [""],
                                         rating: 1,
                                         price: 5,
                                         id: "51"),
                                NftModel(name: "AAA",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/April/1.png"],
                                         rating: 1,
                                         price: 10,
                                         id: "53"),
                                NftModel(name: "BBB",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Aurora/1.png"],
                                         rating: 2,
                                         price: 9,
                                         id: "54"),
                                NftModel(name: "Ccc",
                                         imageURL: ["https://code.s3.yandex.net/Mobile/iOS/NFT/Beige/Bimbo/1.png"],
                                         rating: 3,
                                         price: 8,
                                         id: "55")
]
        let out = mock.filter { arrayOfId.contains($0.id) }
        return completion(.success(out))

    }
    
    
//    func getActualUserData(id: String, _ completion: @escaping (Result<UserModel, Error>) -> Void) {
//        let actualUserRequest = ActualUserRequest(userID: id)
//        networkClient.send(request: actualUserRequest, type: UserModel.self)  { [weak self] result in
//            guard self != nil else { return }
//            DispatchQueue.main.async {
//                switch result {
//                case let .success(data):
//                    completion(.success(data))
//                case let .failure(error):
//                    completion(.failure(error))
//                }
//            }
//        }
//        return
//    }
}

