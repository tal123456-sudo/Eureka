//
//  LogoLabelRow.swift
//  bela
//
//  Created by Muhammet  on 13.03.2023.
//

import Foundation
import Eureka
//import UIKit

final class LogoLabelRow: Row<LogoLabelCell>, RowType {
   // var logo: UIImage?
    var logoURL: URL?
    var labelText: String?
    
    
    required init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<LogoLabelCell>(nibName: "LogoLabelCell")
        cell.height = { 70 }
    }
    
    override func customUpdateCell() {
           cell.configure(with: logoURL, labelText: labelText)
       }

}



