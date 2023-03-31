//
//  League.swift
//  bela
//
//  Created by Muhammet  on 1.03.2023.
//

import Foundation

struct LeagueModel: Codable {
    
    var leagues: [Leagues]?
    
    enum CodingKeys: String, CodingKey {
        case leagues = "response"
    }
  
}

struct Leagues: Codable {
    var league: League?
    
    enum CodingKeys: String, CodingKey {
        case league = "league"
    }
}

struct League: Codable, Equatable {
    static func == (lhs: League, rhs: League) -> Bool {
        return lhs.name == rhs.name
       }
    
    var id: Int?
    var name: String?
    var logo: String?
}




