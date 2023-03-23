//
//  LogoLabelCell.swift
//  bela
//
//  Created by Muhammet  on 13.03.2023.
//

import UIKit
import Eureka
import Kingfisher

class LeagueCell: Cell<String>, CellType {
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    var logoURL: URL?
  
    func configure(with logoURL: URL?, nameLabel: String?) {
        self.logoURL = logoURL
        name.text = nameLabel
        if let url = logoURL {
            logoImageView.kf.setImage(with: url)
        }
    }
}
