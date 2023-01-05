//
//  ScoreCardView.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class ScoreCardView: UIView {
    
    static func loadFromNib() -> ScoreCardView {
        let nib = Bundle.main.loadNibNamed("ScoreCardView", owner: nil, options: nil)?.first as? ScoreCardView
        return nib ?? ScoreCardView()
    }

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
        
}
