//
//  DetailViewModel.swift
//  bela
//
//  Created by Muhammet  on 15.03.2023.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func teamsDidFetchData(teams: [Standing])
    func didFailWithError(error: Error)
}
class DetailViewModel {
    
    private let service: LeagueServiceable
    weak var delegate: DetailViewModelDelegate?
    private lazy var teams: [Standing] = []
    init(service: LeagueServiceable) {
        self.service = service
    }
    
    func fetchData(id: String) {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }
            let result = await self.service.getLeagueDetail(league: id)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    if let teams = response.response?.first?.league?.standings?.first{
                        for i in teams{
                            self.teams.append(i)
                        }
                        self.delegate?.teamsDidFetchData(teams: self.teams )
                    }
                case .failure(let error):
                    self.delegate?.didFailWithError(error: error)
                }
            }
        }
    }
}
