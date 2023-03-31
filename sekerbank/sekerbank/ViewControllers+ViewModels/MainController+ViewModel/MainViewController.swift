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

final class MainViewController: FormViewController, LeagueRowSelectable {
    
    var viewModel: MainViewModel!
    private var service: LeagueServiceable!
    lazy var leagues: [League] = []
    var filteredLeagues: [League] = []
    var leagueId: String? { get {return self.leagueId}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = LeagueService()
        viewModel = MainViewModel(service: service)
        viewModel.delegate = self
        drawSearchBar()
        fetchData()
    }
    
    
    func drawSearchBar() {
        let searchController = UISearchController(searchResultsController: nil) // search bar programatic
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Arama Yap"
        searchController.searchBar.delegate = self // set the delegate to self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    
    func fillForm(leagues: [League]){ // eureka form
        form +++ Section()
        for i in 0..<leagues.count{
            form.last! <<< LeagueRow() { row in
                row.nameLabel = leagues[i].name!
                row.logoURL = URL(string: leagues[i].logo ?? "")
            }.onCellSelection { cell, row in
                self.rowSelected(row, index: leagues[i].id!)
            }
        }
    }
    
    func rowSelected(_ row: LeagueRow, index: Int) {
        let league = index.description
        let vc = DetailViewController()
        vc.leagueId = league
        vc.title = row.nameLabel
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: MainViewModelDelegate{
    
    func didFetchData(leagues: [League]) {
        let leaguesWithoutFirstTwo = Array(leagues.suffix(from: 1)) // Burada ilk 2 elemanı diziden çıkarttım. Çünkü boş geliyordu API ile ilgili bir durum.
        self.leagues = leaguesWithoutFirstTwo
        DispatchQueue.main.async {
            self.fillForm(leagues: self.leagues)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func fetchData(){
        viewModel.fetchData()
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
        guard let searchText = searchController.searchBar.text, searchText.count > 2 else {
            // Minimum 3 characters
            // filteredLeagues.removeAll(keepingCapacity: true)
            // tableView.reloadData()
            return
        }
        filteredLeagues = leagues.filter { $0.name!.lowercased().contains((searchController.searchBar.text?.lowercased())!) }
        form.removeAll(keepingCapacity: true)
        
        
        if !filteredLeagues.isEmpty {
            fillForm(leagues: filteredLeagues)
            
        } else {
            form.removeAll(keepingCapacity: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        form.removeAll(keepingCapacity: true)
        fillForm(leagues: leagues)
        
    }
}
