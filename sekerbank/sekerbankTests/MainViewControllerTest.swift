//
//  MainViewControllerTest.swift
//  sekerbankTests
//
//  Created by Muhammet  on 31.03.2023.
//


import XCTest
@testable import sekerbank

class MainViewControllerTests: XCTestCase {

    var sut: MainViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MainViewController") as? MainViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    func testDidFetchData() throws {
        // Given
        let leagues: [League] = [
            League(id: 1, name: "League 1", logo: "logo1"),
            League(id: 2, name: "League 2", logo: "logo2"),
            League(id: 3, name: "League 3", logo: "logo3"),
            League(id: 4, name: "League 4", logo: "logo4"),
            League(id: 2, name: "League 5", logo: "logo5")
        ]
        // When
        sut.didFetchData(leagues: leagues)
        // Then
        XCTAssertEqual(sut.leagues, leagues)
    }

    func testDidFailWithError() throws {
        // Given
        let error = NSError(domain: "Test Error", code: 404, userInfo: nil)
        // When
        sut.didFailWithError(error: error)
        // Then
        // Test nothing, just make sure the error is printed
    }

}
