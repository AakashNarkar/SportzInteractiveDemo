//
//  MatchCenterTableViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 04/01/23.
//

import UIKit

class MatchCenterTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tourName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var teamAName: UILabel!
    @IBOutlet weak var teamBName: UILabel!
    @IBOutlet weak var teamAScore: UILabel!
    @IBOutlet weak var teamBScore: UILabel!
    @IBOutlet weak var teeamAOver: UILabel!
    @IBOutlet weak var teamBOver: UILabel!
    @IBOutlet weak var stadiumName: UILabel!
    @IBOutlet weak var matchStatuss: UILabel!
    @IBOutlet weak var teamAFlag: UIImageView!
    @IBOutlet weak var teamBFlag: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 12
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(matchDetail: MatchDetailResponse) {
        let tourNameString = "\(matchDetail.matchdetail.match.number) | \(matchDetail.matchdetail.series.tourName)"
        tourName.text = tourNameString
        timeLabel.text = "\(matchDetail.matchdetail.match.date.getFormattedDate()) | \(matchDetail.matchdetail.match.time)"
        let keys = matchDetail.teams.keys.sorted(by: <)
        teamAName.text = matchDetail.teams[keys.first ?? "0"]?.nameShort
        teamBName.text = matchDetail.teams[keys.last ?? "1"]?.nameShort
        teamAScore.text = "\(matchDetail.innings.first?.total ?? "0")/\(matchDetail.innings.first?.wickets ?? "0")"
        teamBScore.text = "\(matchDetail.innings.last?.total ?? "0")/\(matchDetail.innings.last?.wickets ?? "0")"
        teeamAOver.text = matchDetail.innings.first?.overs ?? "0"
        teamBOver.text = matchDetail.innings.last?.overs ?? "0"
        stadiumName.text = matchDetail.matchdetail.venue.name
        matchStatuss.text = matchDetail.matchdetail.result
        teamAFlag.image = UIImage(named: matchDetail.teams[keys.first ?? "0"]?.nameShort ?? "")
        teamBFlag.image = UIImage(named: matchDetail.teams[keys.last ?? "1"]?.nameShort ?? "")
    }
}
