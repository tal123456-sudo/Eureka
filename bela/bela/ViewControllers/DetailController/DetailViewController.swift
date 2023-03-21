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
    func fillForm(){
        form +++ Section()
        for i in 0..<teams.count{
            form.last! <<< LogoDetailRow() { row in
                row.rank = teams[i].rank?.description
                row.logoURL = URL(string: teams[i].team?.logo ?? "")
                row.puan1 = teams[i].all?.win?.description
                row.puan2 = teams[i].all?.played?.description
                row.puan3 = teams[i].all?.draw?.description
                row.puan4 = teams[i].all?.lose?.description
                row.puan5 = teams[i].form?.description
                row.nameguzel = teams[i].team?.name
                row.cellSetup { cell, _ in
                    cell.textLabel?.textColor = .blue
                }
            }
        }
    }
}

