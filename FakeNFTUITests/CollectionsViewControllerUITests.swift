//
//  CollectionsViewControllerUITests.swift
//  FakeNFTUITests
//
//  Created by Александр Поляков on 14.10.2023.
//

import XCTest

class CollectionsViewControllerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append(contentsOf: ["-AppleLanguages", "(en)", "-AppleLocale", "en_US"])
        app.launch()
    }

    func testInitialUIElementsLoaded() {
        selectCatalogFromTabBar()
        let tableView = app.tables.firstMatch
        XCTAssertTrue(tableView.exists, "TableView должен отобразиться")
    }

    func testFilterButtonTapShowsActionSheet() {
        selectCatalogFromTabBar()
        sleep(1)
        let filterButton = app.navigationBars.buttons["SortIcon"]
        XCTAssertTrue(filterButton.exists, "Иконка сортировки должна существовать")
        filterButton.tap()
        sleep(1)
        
        let byNameButton = app.buttons["By name"]
        XCTAssertTrue(byNameButton.exists, "Кнопка 'By name' должна существовать")
    }
    
    func selectCatalogFromTabBar() {
        let catalogTabBarItem = app.tabBars.buttons["Каталог"]
        XCTAssertTrue(catalogTabBarItem.exists, "Таб бар должен существовать")
        catalogTabBarItem.tap()
    }
}

