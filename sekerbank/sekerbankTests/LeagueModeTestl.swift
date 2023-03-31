//
//  LeagueModel.swift
//  sekerbankTests
//
//  Created by Muhammet  on 31.03.2023.
//

import XCTest
@testable import sekerbank

class LeagueTests: XCTestCase {

    func testLeagueEquality() {
        let league1 = League(id: 1, name: "Premier League", logo: "premier_league.png")
        let league2 = League(id: 1, name: "Premier League", logo: "premier_league.png")
        let league3 = League(id: 2, name: "La Liga", logo: "la_liga.png")

        XCTAssertEqual(league1, league2) // Test passes because league1 and league2 have the same values
        XCTAssertNotEqual(league1, league3) // Test passes because league1 and league3 have different ids
    }
}


