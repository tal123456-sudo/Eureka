//
//  DetailViewModelFetchDataTest.swift
//  belaTests
//
//  Created by Muhammet  on 29.03.2023.
//

import XCTest
@testable import bela

class DetailViewModelTest: XCTestCase {

    var viewModel: DetailViewModel!
    var service: MockLeagueService!

    override func setUp() {
        super.setUp()
        service = MockLeagueService()
        viewModel = DetailViewModel(service: service)
    }

    func testFetchDataSuccess() async throws {

        let teams = [Standing(rank: 1,group: "Group1",form: "Form1"),Standing(rank: 2,group: "Group2",form: "Form2")]
        
        XCTAssertEqual(teams.count, 2)
        XCTAssertEqual(teams[0].form, "Form1")
        XCTAssertEqual(teams[1].form, "Form2")
    }
}
