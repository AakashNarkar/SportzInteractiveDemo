//
//  scoreCardTableViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class ScoreCardTableViewCell: UITableViewCell {

    @IBOutlet weak var batterView: UIView!
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var wicketDescLabel: UILabel!
    @IBOutlet weak var srLabel: UILabel!
    @IBOutlet weak var rLabel: UILabel!
    @IBOutlet weak var bLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var sixxLabel: UILabel!
    @IBOutlet weak var rHeaderLabel: UILabel!
    @IBOutlet weak var bHeaderLabel: UILabel!
    @IBOutlet weak var fourHeaderLabel: UILabel!
    @IBOutlet weak var sixHeaderLabel: UILabel!
    @IBOutlet weak var srHeaderLabel: UILabel!
    @IBOutlet weak var batterHeaderLabel: UILabel!

    func configure(indexPath: IndexPath, inning: Inning, commonPlayerArray: [ScoreCardModel]) {
        let player = commonPlayerArray[indexPath.row]
        if indexPath.row < inning.batsmen.count {
            wicketDescLabel.text = inning.batsmen[indexPath.row].howout
            wicketDescLabel.isHidden = false
            setHeaderLabels(batterHeader: "Batsman", rHeader: "R", bHeader: "B", fourHeader: "4s", sixHeader: "6s", srHeader: "SR")
        } else if indexPath.row == inning.batsmen.count || indexPath.row < (inning.batsmen.count + inning.bowlers.count) {
            wicketDescLabel.isHidden = true
            setHeaderLabels(batterHeader: "Bowler", rHeader: "O", bHeader: "M", fourHeader: "R", sixHeader: "W", srHeader: "ER")
        } else if indexPath.row == (inning.batsmen.count + inning.bowlers.count) || (indexPath.count < commonPlayerArray.count) {
            wicketDescLabel.isHidden = true
            setHeaderLabels(batterHeader: "Fall Of Wickets", rHeader: "", bHeader: "", fourHeader: "Score", sixHeader: "", srHeader: "Over")
        }
        playerNameLabel.text = player.playerName
        setValueLabels(rValue: player.rValue, bValue: player.bValue, fourValue: player.fourValue, sixValue: player.sixValue, srValue: player.srValue)
        batterView.isHidden = ((indexPath.row == 0) || (indexPath.row == inning.batsmen.count) || (indexPath.row == (inning.batsmen.count + inning.bowlers.count))) ? false : true
    }
    
    func setHeaderLabels(batterHeader: String, rHeader: String, bHeader: String, fourHeader: String, sixHeader: String, srHeader: String) {
        batterHeaderLabel.text = batterHeader
        rHeaderLabel.text = rHeader
        bHeaderLabel.text = bHeader
        fourHeaderLabel.text = fourHeader
        sixHeaderLabel.text = sixHeader
        srHeaderLabel.text = srHeader
    }
    
    func setValueLabels(rValue: String, bValue: String, fourValue: String, sixValue: String, srValue: String) {
        rLabel.text = rValue
        bLabel.text = bValue
        fourLabel.text = fourValue
        sixxLabel.text = sixValue
        srLabel.text = srValue
    }
}
