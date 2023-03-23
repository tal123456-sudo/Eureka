//
//  LeagueService.swift
//  bela
//
//  Created by Muhammet  on 1.03.2023.
//

import Foundation

protocol LeagueServiceable {
    func getLeague() async -> Result<LeagueModel, RequestError>
    func getLeagueDetail(league: String) async -> Result<LeagueDetail, RequestError>
    
}

struct LeagueService: HTTPClient, LeagueServiceable {
    func getLeague() async -> Result<LeagueModel, RequestError> {
        return await sendRequest(endpoint: LeagueEndpoint.leagues, responseModel: LeagueModel.self)
    }
    
    func getLeagueDetail(league: String) async -> Result<LeagueDetail, RequestError> {
        return await sendRequest(endpoint: LeagueEndpoint.leagueDetail(league: league), responseModel: LeagueDetail.self)
    }
}
