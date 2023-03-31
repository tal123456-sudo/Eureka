//
//  LogoLabelRow.swift
//  bela
//
//  Created by Muhammet  on 13.03.2023.
//

import Foundation
import Eureka

final class LeagueRow: Row<LeagueCell>, RowType {
 
   var logoURL: URL?
   var nameLabel: String?
    
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<LeagueCell>(nibName: "LeagueCell")
        cell.height = { 70 }
    }
    override func customUpdateCell() {
           cell.configure(with: logoURL, nameLabel: nameLabel)
       }
}



