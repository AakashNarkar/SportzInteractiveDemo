//
//  InfoTableViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var infoName: UILabel!
    @IBOutlet weak var infoValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(info: InfoModel) {
        infoName.text = info.infoName
        infoValue.text = info.infoValue
    }
}
