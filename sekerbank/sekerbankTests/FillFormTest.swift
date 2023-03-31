//
//  FillFormTest.swift
//  sekerbankTests
//
//  Created by Muhammet  on 31.03.2023.
//

import XCTest
@testable import sekerbank

class FillFormTest: XCTestCase{
    
    func testFillForm() {
        // Arrange
        let vc = DetailViewController()
        let form = vc.form
        let teams: [Standing] = [
            Standing(rank: 1, team: Team(name: "Team A", logo: ""), all: All(played: 5, win: 3, draw: 1, lose: 1)),
            Standing(rank: 2, team: Team(name: "Team B", logo: ""), all: All(played: 5, win: 2, draw: 2, lose: 1)),
            Standing(rank: 3, team: Team(name: "Team C", logo: ""), all: All(played: 5, win: 2, draw: 1, lose: 2))
        ]
        vc.teams = teams

        // Act
        vc.fillForm()

        // Assert
       // XCTAssertEqual(form.allSections.count, 3)

        // Check first section
        let firstSection = form.allSections[0]
        XCTAssertEqual(firstSection.count, 1)
        let firstRow = firstSection[0] as? LeagueDetailRow
        XCTAssertNotNil(firstRow)
        XCTAssertEqual(firstRow?.name, "Team Name")
        XCTAssertEqual(firstRow?.lose, "L")
        XCTAssertEqual(firstRow?.draw, "D")
        XCTAssertEqual(firstRow?.wins, "W")
        XCTAssertEqual(firstRow?.played, "P")
        XCTAssertEqual(firstRow?.points, "P")
        XCTAssertEqual(firstRow?.rank, "R")

        // Check second section
        let secondSection = form.allSections[1]
        XCTAssertEqual(secondSection.count, teams.count)
        for i in 0..<teams.count {
            let row = secondSection[i] as? LeagueDetailRow
            XCTAssertNotNil(row)
            XCTAssertEqual(row?.rank, teams[i].rank?.description)
            XCTAssertEqual(row?.logoURL, URL(string: teams[i].team?.logo ?? ""))
            XCTAssertEqual(row?.played, teams[i].all?.played?.description)
            XCTAssertEqual(row?.wins, teams[i].all?.win?.description)
            XCTAssertEqual(row?.draw, teams[i].all?.draw?.description)
            XCTAssertEqual(row?.lose, teams[i].all?.lose?.description)
            XCTAssertEqual(row?.name, teams[i].team?.name)
        }
    }

}
