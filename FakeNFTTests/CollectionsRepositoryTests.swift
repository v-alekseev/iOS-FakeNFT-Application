//
//  CollectionsNavigationState.swift
//  FakeNFT
//
//  Created by Александр Поляков on 08.10.2023.
//

@testable import FakeNFT
import XCTest

final class CatalogDataRepositoryTests: XCTestCase {
    var sut: CatalogDataProvider!
    var mockClient: MockNetworkClient!

    override func setUp() {
        super.setUp()
        mockClient = MockNetworkClient()
        sut = CatalogDataProvider(client: mockClient)
    }
    
    func testGiveMeAllCollectionsReturnsCollections() {
        
        // Given
        let mockCollection = [CollectionModel(createdAt: "Date", name: "Test", cover: "CoverURL", nfts: ["1", "2"], description: "TestDescription", id: "1")]
        let data = try! JSONEncoder().encode(mockCollection)
        mockClient.mockData = data

        // When
        let resultCollection = sut.giveMeAllCollections()
                
        // Then
        XCTAssertNotNil(resultCollection)
        XCTAssertEqual(resultCollection.first?.name, "Test")
    }

    func testGiveMeCollectionReturnsCollection() {
        
        // Given
        let mockCollection = CollectionModel(createdAt: "Date", name: "Test", cover: "CoverURL", nfts: ["1", "2"], description: "TestDescription", id: "1")
        let data = try! JSONEncoder().encode(mockCollection)
        mockClient.mockData = data

        // When
        let resultCollection = sut.giveMeCollection(withID: "1")
        
        // Then
        XCTAssertNotNil(resultCollection)
        XCTAssertEqual(resultCollection?.name, "Test")
    }

    override func tearDown() {
        sut = nil
        mockClient = nil
        super.tearDown()
    }
}
