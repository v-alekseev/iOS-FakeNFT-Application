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
        let actionSheet = app.sheets["SortActionSheet"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: actionSheet, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(actionSheet.exists, "Action sheet should appear after filter button tap")
    }
    
    func selectCatalogFromTabBar() {
        let catalogTabBarItem = app.tabBars.buttons["Каталог"]
        XCTAssertTrue(catalogTabBarItem.exists, "Catalog tab bar item should exist")
        catalogTabBarItem.tap()
    }
}

