@testable import FakeNFT
import XCTest

final class ExampleUnitTests: XCTestCase {
    func testExample() {
        // TODO: - Не забудьте написать unit-тесты
    }
    
// каие тесты делаем
    // 1. Тесты DataModel c моками NetworkModel
        // PayDataProvider
        // CardDataProvider
    // 2. Тесты ViewModel  с моками DataModel
        // CartDeleteViewModel
        // PayViewModel
        // CartViewModel
    
    
// структура теста
    
    //given
    //when
    //then
    
    func testCartDeleteVMCreateDefaultDataProvide() {
        //given
        let id = "1"
        let nftImage = UIImage(resource: .nfTcard)
        //when
        var vm = CartDeleteViewModel(nftImage: nftImage, nftIDforDelete: id)
        //then
        XCTAssertTrue(vm.dataProvider != nil)
        XCTAssertTrue(ObjectIdentifier(vm.dataProvider! as! CardDataProvider) == ObjectIdentifier(CardDataProvider.shared))
    }
}


class MockCartDataProvider : CardDataProviderProtocol {
    var order: [FakeNFT.NftDto] = []
    
    let orderChanged = Notification.Name("TestCartUpdated")
    
    func getOrder(_ completion: @escaping (Result<String, Error>) -> Void) {
        <#code#>
    }
    
    func getNFT(id: String, _ completion: @escaping (Result<FakeNFT.NftDto, Error>) -> Void) {
        <#code#>
    }
    
    func removeItemFromCart(idForRemove: String, _ completion: @escaping (Result<[String], Error>) -> Void) {
        <#code#>
    }
    

    
    
}
