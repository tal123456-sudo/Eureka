//
//  ViewController.swift
//  bela
//
//  Created by Muhammet  on 24.02.2023.
//

import UIKit
import Eureka
import SafariServices

//MARK: - Protocols
protocol LeagueOutput {
    func selectedLeague(leagueID: Int)
}


class MainViewController: FormViewController {
// Example Data
    let searchController = UISearchController(searchResultsController: nil)
    var viewModel: MainViewModel!
    var service: LeagueServiceable!

    private var leagues: [League] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = LeagueService()
        viewModel = MainViewModel(service: service)
        
            viewModel.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let leagues = response.leagues?.compactMap({ $0.league}) {
                    self.leagues = Array(leagues)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.fillForm()

                    }
                }
            case .failure(let error):
                print(error)
            }
        }
        definesPresentationContext = true
        
// search bar programatic
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Arama Yap"
        navigationItem.searchController = searchController
        definesPresentationContext = true

   
      
// eureka form
        
    }
    func fillForm(){
        form +++ Section()
        for i in 0..<leagues.count{
            //let sortedData = leagues.sorted{ $0.name ?? "Talha" < $1.name ?? "Talha" }
            form.last! <<< LogoLabelRow() { row in
                row.labelText = leagues[i].name!
                row.logoURL = URL(string: leagues[i].logo ?? "")
                row.cellSetup { cell, _ in
                    cell.textLabel?.textColor = .blue
                }
            }.onCellSelection { cell, row in
                self.rowSelected(row, index: i)
            }
        }
    }
    func rowSelected(_ row: LogoLabelRow, index: Int) {
            let league = leagues[index]
        print(" id: \(league.id!.description)")
        let vc = DetailViewController()
        vc.leagueId = league.id?.description
        navigationController?.pushViewController(vc, animated: true)
        }
}
// Search Bar extention
/*
extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
         guard let searchText = searchController.searchBar.text, searchText.count >= 2 else {
             form.removeAll()
             form +++ Section()
             for i in 0..<leagues.count {
                 form.last! <<< LogoLabelRow() { row in
                     row.labelText = leagues[i].name!
                     row.logoURL = URL(string: leagues[i].logo ?? "")
                     row.cellSetup { cell, _ in
                         cell.textLabel?.textColor = .blue
                     }
                 }
             }
             tableView.reloadData()
             return
         }
         
        let filteredA = leagues.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
         form.removeAll()

         form +++ Section()
         for i in 0..<filteredA.count {
             form.last! <<< LogoLabelRow() { row in
                 row.labelText = leagues[i].name ?? ""
                 row.logoURL = URL(string: leagues[i].logo ?? "")
                 row.cellSetup { cell, _ in
                     cell.textLabel?.textColor = .blue
                 }
             }
         }
         tableView.reloadData()
        return
     }
}


*/
extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count > 2 else {
            // Minimum 2 karakter
            tableView.reloadData()
            return
        }
        
        let filteredLeagues = leagues.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        
     
        form.removeAll()
        form +++ Section()
        
        for league in filteredLeagues {
            form.last! <<< LogoLabelRow() { row in
                row.labelText = league.name ?? ""
                row.logoURL = URL(string: league.logo ?? "")
                row.cellSetup { cell, _ in
                    cell.textLabel?.textColor = .blue
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
          guard let searchText = searchBar.text, searchText.isEmpty else {
              return
          }
          
          form.removeAll()
          form +++ Section()
          for i in 0..<leagues.count {
              form.last! <<< LogoLabelRow() { row in
                  row.labelText = leagues[i].name!
                  row.logoURL = URL(string: leagues[i].logo ?? "")
                  row.cellSetup { cell, _ in
                      cell.textLabel?.textColor = .blue
                  }
              }
          }
          tableView.reloadData()
      }

}

