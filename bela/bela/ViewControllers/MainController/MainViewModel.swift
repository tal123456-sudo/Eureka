//
//  MainViewModel.swift
//  bela
//
//  Created by Muhammet  on 10.03.2023.
//

import Foundation

class MainViewModel {
    
    private let service: LeagueServiceable
    
    init(service: LeagueServiceable) {
        self.service = service
    }
    
    func fetchData(completion: @escaping (Result<LeagueModel, RequestError>) -> Void) {
        Task(priority: .background) {
            let result = await service.getLeague()
            completion(result)
        }
    }
}

