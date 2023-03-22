//
//  ViewController.swift
//  bela
//
//  Created by Muhammet  on 24.02.2023.
//

import UIKit
import Eureka

class MainViewController: FormViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    var viewModel: MainViewModel!
    private var service: LeagueServiceable!
    
    lazy var leagues: [League] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = LeagueService()
        viewModel = MainViewModel(service: service)
        fetchData()
        drawSearchBar()
        fillForm()
    }
    
    private func fetchData(){
        viewModel.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let leagues = response.leagues?.compactMap({ $0.league}) {
                    self.leagues = Array(leagues)
                }
                DispatchQueue.main.async {
                    self.fillForm()
                }
            case .failure(let error):
                print(error)
            }
        }
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
                self.rowSelected(row, index: i)
            }
        }
    }
    
    func rowSelected(_ row: LeagueRow, index: Int) {
        let league = leagues[index]
        print(" id: \(league.id!.description)")
        let vc = DetailViewController()
        vc.leagueId = league.id?.description
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
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
            form.last! <<< LeagueRow() { row in
                row.nameLabel = leagues[i].name!
                row.logoURL = URL(string: leagues[i].logo ?? "")
                row.cellSetup { cell, _ in
                    cell.textLabel?.textColor = .blue
                }
            }
        }
        tableView.reloadData()
    }
}

