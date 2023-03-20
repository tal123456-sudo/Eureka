//
//  LogoLabelCell.swift
//  bela
//
//  Created by Muhammet  on 13.03.2023.
//

import UIKit
import Eureka
import Kingfisher

class LogoLabelCell: Cell<String>, CellType {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    var logoURL: URL?
    var leagueId: String?
    
    func configure(with logoURL: URL?, labelText: String?) {
        self.logoURL = logoURL
        label.text = labelText
      
        if let url = logoURL {
            logoImageView.kf.setImage(with: url)
        }
    }
    
}
