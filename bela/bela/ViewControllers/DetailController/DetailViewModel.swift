//
//  DetailViewModel.swift
//  bela
//
//  Created by Muhammet  on 15.03.2023.
//

import Foundation

class DetailViewModel {
    
    private let service: LeagueServiceable
    
    init(service: LeagueServiceable) {
        self.service = service
    }
    
    func fetchData(id: String, completion: @escaping (Result<LeagueDetail, RequestError>) -> Void) {
        Task(priority: .background) {
            let result = await service.getLeagueDetail(league: id)
            completion(result)
        }
    }
}
