//
//  DetailViewController.swift
//  bela
//
//  Created by Muhammet  on 15.03.2023.
//

import Foundation
import UIKit
import Eureka


final class DetailViewController: FormViewController, DetailViewModelDelegate {
    
    var leagueId: String?
    var detailViewModel: DetailViewModel!
    private var service: LeagueServiceable!
    lazy var teams: [Standing] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = LeagueService()
        detailViewModel = DetailViewModel(service: service)
        detailViewModel.delegate = self
        fetchData()
    }
    
    private func fillForm(){
        form +++ Section()
        form.last! <<< LeagueDetailRow(){ row in
            row.name = "Team Name"
            row.lose = "Lose"
            row.draw = "Draw"
            row.wins = "Wins"
            row.played = "Played"
            row.points = "Points"
            row.rank = "Rank"
        }
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

extension DetailViewController:LeagueRowSelectable {
    func teamsDidFetchData(teams: [Standing]) {
        self.teams = teams
        self.fillForm()
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    private func fetchData(){
        if let id = leagueId {
            detailViewModel?.fetchData(id: id)
        }
    }
}
