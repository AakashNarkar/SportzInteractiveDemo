//
//  SquadTableViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

protocol SquadDelegate: AnyObject {
    func didTapOnCell(_ index: Int, _ isFirtTeam: Bool)
}

class SquadTableViewCell: UITableViewCell {

    @IBOutlet weak var squadOneView: UIView!
    @IBOutlet weak var ssquadTwoView: UIView!
    
    var index = 0
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
    
    func configure(index: Int, delegate: SquadDelegate) {
        self.index = index
        self.delegate = delegate
    }
    
    @objc func tapAction(_ gesture: UIGestureRecognizer) {
        delegate?.didTapOnCell(index, gesture.view?.tag == 0)
    }
}
