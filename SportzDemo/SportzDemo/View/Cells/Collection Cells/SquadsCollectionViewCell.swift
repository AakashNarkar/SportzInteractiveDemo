//
//  SquadsCollectionViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 04/01/23.
//

import UIKit

class SquadsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var squadTableView: UITableView!
    @IBOutlet weak var teamAFlag: UIImageView!
    @IBOutlet weak var teamBFlag: UIImageView!
    @IBOutlet weak var teamAName: UILabel!
    @IBOutlet weak var teamBName: UILabel!
    
    weak var delegate: SquadDelegate?
    private var teamDetail: [String: Team]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    // MARK: - setupUI
    func setupUI() {
        squadTableView.delegate = self
        squadTableView.dataSource = self
        squadTableView.register(UINib(nibName: ScreenConstant.squadTableViewCell, bundle: nil), forCellReuseIdentifier: ScreenConstant.squadTableViewCell)
    }
    
    func configure(teamDetail: [String: Team]) {
        let keys = teamDetail.keys.sorted(by: <)
        teamAName.text = teamDetail[keys.first ?? "0"]?.nameShort
        teamBName.text = teamDetail[keys.last ?? "1"]?.nameShort
        teamAFlag.image = UIImage(named: teamDetail[keys.first ?? "0"]?.nameShort ?? "")
        teamBFlag.image = UIImage(named: teamDetail[keys.last ?? "1"]?.nameShort ?? "")
        self.teamDetail = teamDetail
    }
}

// MARK:  - UITableViewDelegate, UITableViewDataSource
extension SquadsCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let keys = teamDetail?.keys.sorted(by: <)
        return teamDetail?[keys?.first ?? "0"]?.players.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScreenConstant.squadTableViewCell) as? SquadTableViewCell {
            if let teamDetail = teamDetail {
                let keys = teamDetail.keys.sorted(by: <)
                let teamAPlayerKeys = teamDetail[keys.first ?? "0"]?.players.keys.map { $0 }.sorted(by: <)
                let teamBPlayerKeys = teamDetail[keys.last ?? "0"]?.players.keys.map { $0 }.sorted(by: <)
                if let teamAPlayer = teamDetail[keys.first ?? "0"]?.players[teamAPlayerKeys?[indexPath.row] ?? ""],
                   let teamBPlayer = teamDetail[keys.last ?? "0"]?.players[teamBPlayerKeys?[indexPath.row] ?? ""]
                {
                    cell.configure(index: indexPath.item, delegate: self, teamAPlayer: teamAPlayer, teamBPlayer: teamBPlayer)
                }
            }
            return  cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: squadTableView.bounds.width, height: 30))
        headerView.backgroundColor = .systemGray4
        let label = UILabel(frame: CGRect(x: 0, y: 5, width: 100, height: 20))
        label.text = ScreenConstant.matches
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.text = ScreenConstant.playing11
        label.center = headerView.center
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}

// MARK: - SquadDelegate
extension SquadsCollectionViewCell: SquadDelegate {
    func didTapOnCell(_ player: Player) {
        delegate?.didTapOnCell(player)
    }
}
