//
//  LeagueEndpoint.swift
//  bela
//
//  Created by Muhammet  on 1.03.2023.
//

import Foundation

enum LeagueEndpoint {
    case leagues
    case leagueDetail(league: String)
}

extension LeagueEndpoint: Endpoint {
    var path: String {
        switch self {
        case .leagues:
            return "/v3/leagues"
        case .leagueDetail(_):
            return "/v3/standings"
        }
    }

    var method: RequestMethod {
        switch self {
        case .leagues, .leagueDetail:
            return .get
        }
    }

    var header: [String: String]? {
        let X_RapidAPI_Key = "b16ff17f20mshc765c4390a566cap11906fjsna489fbd5fe6d"
        let X_RapidAPI_Host = "api-football-v1.p.rapidapi.com"
        switch self {
        case .leagues, .leagueDetail(_):
            return [
                "X-RapidAPI-Key": X_RapidAPI_Key,
                "X-RapidAPI-Host": X_RapidAPI_Host
            ]
        }
    }
    var body: [String: String]? {
        switch self {
        case .leagues, .leagueDetail(league: _):
            return nil
        }
    
    }
    var params: [String: String]? {
        switch self {
        case .leagues:
            return nil
        case .leagueDetail(let value):
            return ["season": "2022","league": value]
        }
    
    }
}
