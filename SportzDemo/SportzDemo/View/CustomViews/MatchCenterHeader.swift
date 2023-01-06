//
//  MatchCenterHeader.swift
//  SportzDemo
//
//  Created by Neosoft on 06/01/23.
//

import UIKit

protocol MatchCenterHeaderDelegate: AnyObject {
    func didSelectSorting(isAcsending: Bool)
}

class MatchCenterHeader: UIView {

    @IBOutlet weak var sortBtton: UIButton!
    weak var delegate: MatchCenterHeaderDelegate?
  
    static func loadFromNib() -> MatchCenterHeader {
        let nib = Bundle.main.loadNibNamed(ScreenConstant.matchCenterHeader, owner: nil, options: nil)?.first as? MatchCenterHeader
        return nib ?? MatchCenterHeader()
    }
    
    @IBAction func sortButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.didSelectSorting(isAcsending: sender.isSelected)
    }
    
    func configure(isAscending: Bool) {
        sortBtton.isSelected = isAscending
        sortBtton.setImage(UIImage(systemName: sortBtton.isSelected ? "chevron.up" : "chevron.down"), for: .normal)
    }
}
