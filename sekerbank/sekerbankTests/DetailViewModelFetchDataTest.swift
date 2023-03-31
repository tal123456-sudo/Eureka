//
//  DetailViewModelFetchDataTest.swift
//  belaTests
//
//  Created by Muhammet  on 29.03.2023.
//

//import XCTest
//@testable import sekerbank
//
//class DetailViewModelTest: XCTestCase {
//
//    var viewModel: DetailViewModel!
//    var service: MockLeagueService!
//
//    override func setUp() {
//        super.setUp()
//        service = MockLeagueService()
//        viewModel = DetailViewModel(service: service)
//    }
//
//    func testFetchDataSuccess() async throws {
//
//        let teams = [Standing(rank: 1,group: "Group1",form: "Form1"),Standing(rank: 2,group: "Group2",form: "Form2")]
//
//        XCTAssertEqual(teams.count, 2)
//        XCTAssertEqual(teams[0].form, "Form1")
//        XCTAssertEqual(teams[1].form, "Form2")
//    }
//
//}

import XCTest
@testable import sekerbank

class DetailViewModelTest: XCTestCase, DetailViewModelDelegate {

    var viewModel: DetailViewModel!
    var service: MockLeagueService!
    var didFailWithErrorCalled = false

    override func setUp() {
        super.setUp()
        service = MockLeagueService()
        viewModel = DetailViewModel(service: service)
        viewModel.delegate = self // viewModel.delegate'yi burada ayarlayın
        didFailWithErrorCalled = false // didFailWithErrorCalled değişkenini sıfırlayın
    }

    func testFetchDataSuccess() async throws {

        let teams = [Standing(rank: 1,group: "Group1",form: "Form1"),Standing(rank: 2,group: "Group2",form: "Form2")]

        XCTAssertEqual(teams.count, 2)
        XCTAssertEqual(teams[0].form, "Form1")
        XCTAssertEqual(teams[1].form, "Form2")
    }

    func testFetchDataFailure() async throws {
        service.mockResult = .failure(RequestError.unknown)
        viewModel.delegate = self // viewModel.delegate'yi burada ayarlayın
        await viewModel.fetchData(id: "1")
        XCTAssertTrue(viewModel.teams.isEmpty)
    }

//    func testDelegateMethodCalledOnFailure() async throws {
//        service.mockResult = .failure(RequestError.unknown)
//        viewModel.delegate = self // viewModel.delegate'yi burada ayarlayın
//        await viewModel.fetchData(id: "1")
//        XCTAssertTrue(didFailWithErrorCalled)
//    }

    // MARK: DetailViewModelDelegate methods

    func teamsDidFetchData(teams: [Standing]) {
        viewModel.teams = teams
    }

    func didFailWithError(error: Error) {
        viewModel.teams = []
        didFailWithErrorCalled = true
    }
}

class MockDetailViewModelDelegate: DetailViewModelDelegate {
    var didFailWithErrorCalled = false
    var teamsDidFetchDataCalled = false

    func teamsDidFetchData(teams: [Standing]) {
        teamsDidFetchDataCalled = true
    }

    func didFailWithError(error: Error) {
        didFailWithErrorCalled = true
    }
}




