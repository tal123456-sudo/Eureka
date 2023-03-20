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

// MARK: - League
struct LeagueDetailModel: Codable {
    var id: Int?
    var name: String?
    var country: String?
    var logo: String?
    var flag: String?
    var standing: [Standing]?
}

// MARK: - Standing
struct Standing: Codable {
    var rank: Int?
    var team: Team?
    var points, goalsDiff: Int?
    var group: String?
    var form: String?
    var status: Status?
    var description: String?
    var all, home, away: All?
    var update: Date?
}

// MARK: - All
struct All: Codable {
    var played, win, draw, lose: Int?
    var goals: Goals?
}

// MARK: - Goals
struct Goals: Codable {
    var goalsFor, against: Int?

    enum CodingKeys: String, CodingKey {
        case goalsFor
        case against
    }
}

enum Status: String, Codable {
    case down = "down"
    case same = "same"
    case up = "up"
}

// MARK: - Team
struct Team: Codable {
    var id: Int?
    var name: String?
    var logo: String?
}

/*
struct LeagueDetail: Codable {

    var leaguess: [Leaguess]?
    
      enum CodingKeys: String, CodingKey {
          case leaguess = "response"
      }
}
struct Leaguess: Codable {
    var standings: [Standing]?
}
struct Standing: Codable {
    var rank: Int?
    var team: Team?
    var points, goalsDiff: Int?
    var form: String?
    var description: String?
    var all, home, away: All?
}

// MARK: - All
struct All: Codable {
    var played, win, draw, lose: Int?
    var goals: Goals?
}

// MARK: - Goals
struct Goals: Codable {
    var goalsFor, against: Int?

    enum CodingKeys: String, CodingKey {
        case goalsFor
        case against
    }
}

// MARK: - Team
struct Team: Codable {
    var id: Int?
    var name: String?
    var logo: String?
}

*/

/*
struct LeagueDetail: Codable {
    var results: Int?
    var response: [Response]?
  

    enum CodingKeys: String, CodingKey {
        case  results, response
    }
}

// MARK: - Parameters
struct Parameters: Codable {
    var league, season: String?
}

// MARK: - Response
struct Response: Codable {
    var league: Leaguess?
}

// MARK: - League
struct Leaguess: Codable {
    var id: Int?
    var name: Name?
    var country: String?
    var logo: String?
    var flag: String?
    var season: Int?
    var standings: [[Standing]]?
}

enum Name: String, Codable {
    case premierLeague = "Premier League"
}

// MARK: - Standing
struct Standing: Codable {
    var rank: Int?
    var team: Team?
    var points, goalsDiff: Int?
    var group: Name?
    var form: String?
    var status: Status?
    var description: String?
    var all, home, away: All?
}

// MARK: - All
struct All: Codable {
    var played, win, draw, lose: Int?
    var goals: Goals?
}

// MARK: - Goals
struct Goals: Codable {
    var goalsFor, against: Int?

    enum CodingKeys: String, CodingKey {
        case goalsFor
        case against
    }
}

enum Status: String, Codable {
    case same = "same"
}

// MARK: - Team
struct Team: Codable {
    var id: Int?
    var name: String?
    var logo: String?
}
*/
