//
//  SquadTableViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

protocol SquadDelegate: AnyObject {
    func didTapOnCell(_ player: Player)
}

class SquadTableViewCell: UITableViewCell {

    @IBOutlet weak var squadOneView: UIView!
    @IBOutlet weak var ssquadTwoView: UIView!
    @IBOutlet weak var squadOneName: UILabel!
    @IBOutlet weak var squadTwoName: UILabel!
    
    var index = 0
    var teamAPlayer: Player?
    var teamBPlayer: Player?
    weak var delegate: SquadDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        var tap: UITapGestureRecognizer {
                get {
                    return UITapGestureRecognizer(target: self, action: #selector(self.tapAction(_:)))
                }
            }
        squadOneView.addGestureRecognizer(tap)
        ssquadTwoView.addGestureRecognizer(tap)
    }
    
    func configure(index: Int, delegate: SquadDelegate, teamAPlayer: Player, teamBPlayer: Player) {
        self.index = index
        self.delegate = delegate
        self.squadOneName.text = setPlayerName(player: teamAPlayer)
        self.squadTwoName.text = setPlayerName(player: teamBPlayer)
        self.teamAPlayer = teamAPlayer
        self.teamBPlayer = teamBPlayer
    }
    
    func setPlayerName(player: Player) -> String {
        var name = player.nameFull
        
        if let _ = player.iscaptain, let _ = player.iskeeper {
            name += " (wk & c)"
            return name
        }
        
        if let _ = player.iskeeper {
            name += " (wk)"
            return name
        }
        
        if let _ = player.iscaptain {
            name += " (c)"
            return name
        }

        return name
    }
    
    @objc func tapAction(_ gesture: UIGestureRecognizer) {
        if let teamAPlayer = teamAPlayer, let teamBPlayer = teamBPlayer {
            delegate?.didTapOnCell(gesture.view?.tag == 0 ? teamAPlayer : teamBPlayer)
        }
    }
}
