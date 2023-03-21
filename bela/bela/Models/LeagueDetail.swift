//
//  Movie.swift
//  bela
//
//  Created by Muhammet  on 1.03.2023.
//

import Foundation

struct LeagueDetail: Codable {

    var response: [Response]?

    enum CodingKeys: String, CodingKey {
        case response
    }
}

struct Response: Codable {
    var league: LeagueDetailModel?
}

struct LeagueDetailModel: Codable {
    var id: Int?
    var name: String?
    var country: String?
    var logo: String?
    var flag: String?
    var standings: [[Standing]]?
}

struct Standing: Codable {
    var rank: Int?
    var team: Team?
    var points, goalsDiff: Int?
    var group: String?
    var form: String?
    var description: String?
    var all, home, away: All?
    var update: String?
}

struct All: Codable {
    var played, win, draw, lose: Int?
}

struct Team: Codable {
    var id: Int?
    var name: String?
    var logo: String?
}

