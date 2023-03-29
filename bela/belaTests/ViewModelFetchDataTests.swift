//
//  belaTests.swift
//  belaTests
//
//  Created by Muhammet  on 24.02.2023.
//

import XCTest
@testable import bela

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    var service: MockLeagueService!
    
    override func setUp() {
        super.setUp()
        service = MockLeagueService()
        viewModel = MainViewModel(service: service)
    }
    
    
    func testFetchDataSuccess() async throws {

        let leagues = [League(id: 1, name: "League 1", logo: "logo1"), League(id: 2, name: "League 2", logo: "logo2")]
        service.mockResult = .success(LeagueModel(leagues: leagues.map { Leagues(league: $0) }))
  
        XCTAssertEqual(leagues.count, 2)
        XCTAssertEqual(leagues[0].name, "League 1")
        XCTAssertEqual(leagues[1].name, "League 2")
    }
}

class MockLeagueService: LeagueServiceable {
    var mockResult: Result<LeagueModel, RequestError>?

    func getLeague() async -> Result<LeagueModel, RequestError> {
        return mockResult ?? .failure(RequestError.unknown)
    }

    func getLeagueDetail(league: String) async -> Result<LeagueDetail, RequestError> {
        return .failure(RequestError.unknown)
    }
}
