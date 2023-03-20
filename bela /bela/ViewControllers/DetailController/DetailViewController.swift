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
    var teams: [Standing] = []
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = .red
        //   print("selam", leagueId!)
        super.viewDidLoad()
        service = LeagueService()
        detailViewModel = DetailViewModel(service: service)
        if let leagueId = leagueId {
            detailViewModel.fetchData(id: leagueId) { [weak self] result in
               
                switch result {
                case .success(let response):
                    if let asdf = response.response?.first?.league?.standings?.first{
                        for i in asdf{
                            self?.teams.append(i)
//                            print(i.team?.name)
                        }
                        for i in 0..<asdf.count {
                                print(self?.teams[i].team?.name)
                               
                            
                        }
                        
                    }
                    
            
                   
                  
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}

