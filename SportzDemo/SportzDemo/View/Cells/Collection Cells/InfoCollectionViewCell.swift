//
//  InfoCollectionViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var infoTableView: UITableView!
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
    
    private var info: [InfoModel]?
    private var matchDetail: MatchDetailResponse?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    func setupUI() {
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(UINib(nibName: ScreenConstant.infoTableViewCell, bundle: nil), forCellReuseIdentifier: ScreenConstant.infoTableViewCell)
    }
    
    func configureCell(matchDetail: MatchDetailResponse, info: [InfoModel]) {
        let tourNameString = "\(matchDetail.matchdetail.match.number) | \(matchDetail.matchdetail.series.tourName)"
        tourName.text = tourNameString
        timeLabel.text = "\(matchDetail.matchdetail.match.date) | \(matchDetail.matchdetail.match.time)"
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
        
        self.info = info
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension InfoCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return info?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScreenConstant.infoTableViewCell) as? InfoTableViewCell {
            if let info = info {
                cell.configure(info: info[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: infoTableView.bounds.width, height: 30))
        headerView.backgroundColor = .systemGray4
        let label = UILabel(frame: CGRect(x: 16, y: 5, width: 100, height: 20))
        label.text = ScreenConstant.info
        label.font = .systemFont(ofSize: 14, weight: .bold)
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
