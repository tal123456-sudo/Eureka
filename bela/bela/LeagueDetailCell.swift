//
//  LeagueDetailCell.swift
//  bela
//
//  Created by Muhammet  on 21.03.2023.
//

import UIKit
import Eureka
class LeagueDetailCell: Cell<String>, CellType {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var puan1Label: UILabel!
    @IBOutlet weak var logoLabel: UIImageView!
    @IBOutlet weak var puan2Label: UILabel!
    @IBOutlet weak var puan3Label: UILabel!
    @IBOutlet weak var puan4Label: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    var teamLogoURL: URL?
    
    func configure(with teamLogoURL: URL?, rank: String?, puan1:String?, puan2:String?, puan3:String?, puan4:String?,nameguzel:String?) {
        self.teamLogoURL = teamLogoURL
        rankLabel.text = rank?.description
        puan1Label.text = puan1?.description
        puan2Label.text = puan2?.description
        puan3Label.text = puan3?.description
        puan4Label.text = puan4?.description
        teamNameLabel.text = nameguzel?.description
      
        if let url = teamLogoURL {
           logoLabel.kf.setImage(with: url)
        }
    }

}
