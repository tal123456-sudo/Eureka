//
//  DetailViewController.swift
//  bela
//
//  Created by Muhammet  on 15.03.2023.
//

import Foundation
import UIKit
import Eureka

class DetailViewController: FormViewController{
    
    var detailViewModel: DetailViewModel?
    var leagueId: String?
    private var service: LeagueServiceable!
    
    lazy var teams: [Standing] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = LeagueService()
        detailViewModel = DetailViewModel(service: service)
        
        if let leagueId = leagueId {
            detailViewModel?.fetchData(id: leagueId) { [weak self] result in
                switch result {
                case .success(let response):
                    if let detail = response.response?.first?.league?.standings?.first{
                        for i in detail{
                            self?.teams.append(i)
                        }
                    }
                    DispatchQueue.main.async {
                        self?.fillForm()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func fillForm(){
        form +++ Section()
        for i in 0..<teams.count{
            form.last! <<< LeagueDetailRow() { row in
                row.rank = teams[i].rank?.description
                row.logoURL = URL(string: teams[i].team?.logo ?? "")
                row.played = teams[i].all?.played?.description
                row.wins = teams[i].all?.win?.description
                row.draw = teams[i].all?.draw?.description
                row.lose = teams[i].all?.lose?.description
                row.name = teams[i].team?.name
            }
        }
    }
}

