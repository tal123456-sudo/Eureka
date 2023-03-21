//
//  LogoDetailRow.swift
//  bela
//
//  Created by Muhammet  on 21.03.2023.
//

import Foundation
import Eureka

final class LogoDetailRow: Row<LeagueDetailCell>, RowType {
    var logoURL: URL?
    var rank: String?
    var puan1: String?
    var puan2: String?
    var puan3: String?
    var puan4: String?
    var nameguzel: String?
    var puan5: String?
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<LeagueDetailCell>(nibName: "LeagueDetailCell")
        cell.height = { 70 }
    }
    
    override func customUpdateCell() {
        cell.configure(with: logoURL, rank: rank, puan1:puan1, puan2:puan2, puan3:puan3, puan4:puan4,nameguzel:nameguzel)
       }
}
