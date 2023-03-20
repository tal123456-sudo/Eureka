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
    
    var detailViewModel: DetailViewModel!
    var leagueId: String?
    var service: LeagueServiceable!
    
    //var teams:[LeagueDetail] =
    var teams: [LeagueDetail] = []
    
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        //   print("selam", leagueId!)
        super.viewDidLoad()
        service = LeagueService()
        detailViewModel = DetailViewModel(service: service)
        if let leagueId = leagueId {
            detailViewModel.fetchData(id: leagueId) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    
                    print(response.response?.first)
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

