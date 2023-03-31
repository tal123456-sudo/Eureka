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
    @IBOutlet weak var winsLabel: UILabel!
    @IBOutlet weak var teamLogoLabel: UIImageView!
    @IBOutlet weak var loseLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var playedLabel: UILabel!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    var teamLogoURL: URL?
    
    func configure(with teamLogoURL: URL?, rank: String?, wins:String?, draw:String?, lose:String?, played:String?,points:String?, name:String) {
        self.teamLogoURL = teamLogoURL
        rankLabel.text = rank?.description
        winsLabel.text = wins?.description
        loseLabel.text = draw?.description
        drawLabel.text = lose?.description
        playedLabel.text = played?.description
        teamNameLabel.text = name.description
      
        if let url = teamLogoURL {
           teamLogoLabel.kf.setImage(with: url)
        }
    }
}
