//
//  LogoDetailRow.swift
//  bela
//
//  Created by Muhammet  on 21.03.2023.
//
import Foundation
import Eureka

final class LeagueDetailRow: Row<LeagueDetailCell>, RowType {
    var logoURL: URL?
    var rank: String?
    var wins: String?
    var draw: String?
    var lose: String?
    var played: String?
    var points: String?
    var name: String?
    
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<LeagueDetailCell>(nibName: "LeagueDetailCell")
        cell.height = { 70 }
    }
    
    override func customUpdateCell() {
        cell.configure(with: logoURL, rank: rank, wins: wins, draw: draw, lose: lose, played: played,points: points,name: name!)
       }
}
