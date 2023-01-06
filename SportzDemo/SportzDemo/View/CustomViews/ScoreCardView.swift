//
//  ScoreCardView.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class ScoreCardView: UIView {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var dropDownImage: UIImageView!
    
    static func loadFromNib() -> ScoreCardView {
        let nib = Bundle.main.loadNibNamed(ScreenConstant.scoreCardView, owner: nil, options: nil)?.first as? ScoreCardView
        return nib ?? ScoreCardView()
    }
       
    func configure(team: String, score: String, isSectionSelected: Bool, section: Int) {
        teamName.text = team
        scoreLabel.text = score
        self.backgroundColor = isSectionSelected ? .white : .gray
        self.tag = section
        dropDownImage.image = UIImage(systemName: isSectionSelected ? "chevron.down" : "chevron.up")
    }
}
