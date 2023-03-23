//
//  MainViewModel.swift
//  bela
//
//  Created by Muhammet  on 10.03.2023.
//

import Foundation
protocol MainViewModelDelegate: AnyObject {
    func didFetchData(leagues: [League])
    func didFailWithError(error: Error)
}

class MainViewModel {
    
    private let service: LeagueServiceable
    weak var delegate: MainViewModelDelegate?
    private lazy var leagues: [League] = []

    init(service: LeagueServiceable) {
        self.service = service
    }
    
    func fetchData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }
            let result = await service.getLeague()
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    if let leagues = response.leagues?.compactMap({ $0.league}) {
                        self.delegate?.didFetchData(leagues: leagues)
                    }
                case .failure(let error):
                    self.delegate?.didFailWithError(error: error)
                }
            }
        }
    }
}
