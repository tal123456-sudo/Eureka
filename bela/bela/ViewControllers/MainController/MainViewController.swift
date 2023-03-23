//
//  ViewController.swift
//  bela
//
//  Created by Muhammet  on 24.02.2023.
//

import UIKit
import Eureka

protocol LeagueRowSelectable {
    var leagueId: String? { get }
}
class MainViewController: FormViewController, LeagueRowSelectable {
   
    var viewModel: MainViewModel!
    private var service: LeagueServiceable!
    lazy var leagues: [League] = []
    var leagueId: String? { get {return self.leagueId}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = LeagueService()
            viewModel = MainViewModel(service: service)
            viewModel.delegate = self
            drawSearchBar()
            fetchData()
    }
    
    private func drawSearchBar(){
        let searchController = UISearchController(searchResultsController: nil) // search bar programatic
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Arama Yap"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fillForm(){ // eureka form
        form +++ Section()
        for i in 0..<leagues.count{
            form.last! <<< LeagueRow() { row in
                row.nameLabel = leagues[i].name!
                row.logoURL = URL(string: leagues[i].logo ?? "")
            }.onCellSelection { cell, row in
                self.rowSelected(row, index: self.leagues[i].id ?? 2)
            }
        }
    }
    
    func rowSelected(_ row: LeagueRow, index: Int) {
        let league = index.description
        let vc = DetailViewController()
        vc.leagueId = league
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    // ALLAH BELANI VERECEK SEARCH BAR KERE!!!!
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, searchText.count > 2 else {
            // Minimum 2 karakter
            tableView.reloadData()
            return
        }
        
        lazy var filteredLeagues = leagues.filter { $0.name!.lowercased().contains(searchText.lowercased()) }
        form.removeAll()
        
        form +++ Section()
        for league in filteredLeagues {
            form.last! <<< LeagueRow() { row in
                row.nameLabel = league.name ?? ""
                row.logoURL = URL(string: league.logo ?? "")
                row.cellSetup { cell, _ in
                    cell.textLabel?.textColor = .blue
                }.onCellSelection { cell, row in
                    self.rowSelected(row, index: league.id ?? 2)
                }
            }
        }
//        tableView.reloadData()
//
    }
    
    private func searchBarTextDidEndEditing(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.isEmpty {
            return form.removeAll()
           
        }
      
        tableView.reloadData()
    }
    
    private func searchBarCancelButtonClicked(for searchController: UISearchController) {
        form.removeAll()
        fillForm()
    }
}

extension MainViewController: MainViewModelDelegate{
    
    func didFetchData(leagues: [League]) {
        let leaguesWithoutFirstTwo = Array(leagues.suffix(from: 2)) // Burada ilk 2 elemanı diziden çıkarttım. Çünkü boş geliyordu API ile ilgili bir durum.
        self.leagues = leaguesWithoutFirstTwo
        DispatchQueue.main.async {
            self.fillForm()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    private func fetchData(){
        viewModel.fetchData()
    }
}
 

