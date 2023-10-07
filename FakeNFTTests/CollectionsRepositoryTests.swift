@testable import FakeNFT
import XCTest

final class CatalogDataRepositoryTests: XCTestCase {
    var sut: CatalogDataRepository!
    var mockClient: MockNetworkClient!

    override func setUp() {
        super.setUp()
        mockClient = MockNetworkClient()
        sut = CatalogDataRepository(client: mockClient)
    }
    
    func testFetchCollectionsReturnsCollections() {
        
        // Given
        let mockCollection = [CollectionModel(createdAt: "Date", name: "Test", cover: "CoverURL", nfts: ["1", "2"], description: "TestDescription", id: "1")]
        let data = try! JSONEncoder().encode(mockCollection)
        mockClient.mockData = data

        // When
        var resultCollection: [CollectionModel]?
        resultCollection = sut.giveMeAllCollections()
        
        // Then
        XCTAssertNotNil(resultCollection)
        XCTAssertEqual(resultCollection?[0].name, "Test")
    }

    func testFetchCollectionReturnsCollection() {
        
        // Given
        let mockCollection = CollectionModel(createdAt: "Date", name: "Test", cover: "CoverURL", nfts: ["1", "2"], description: "TestDescription", id: "1")
        let data = try! JSONEncoder().encode(mockCollection)
        mockClient.mockData = data

        // When
        var resultCollection: CollectionModel?
        resultCollection = sut.giveMeCollection(id: 1)
        
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
