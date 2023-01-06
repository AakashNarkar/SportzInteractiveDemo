//
//  ScoreCardCollectionViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class ScoreCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scoreCardTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    var matchDetail: MatchDetailResponse?
    var hiddenSections = Set<Int>()
    var viewModel: MatchDetailsViewModel?
    var isSectionSelected = [false, false]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       setupUI()
    }
    
    func setupUI() {
        scoreCardTableView.delegate = self
        scoreCardTableView.dataSource = self
        scoreCardTableView.register(UINib(nibName: ScreenConstant.scoreCardTableViewCell, bundle: nil), forCellReuseIdentifier: ScreenConstant.scoreCardTableViewCell)
    }
    
    func configure(matchDetail: MatchDetailResponse, viewModel: MatchDetailsViewModel) {
        self.matchDetail = matchDetail
        self.statusLabel.text = matchDetail.matchdetail.result
        self.viewModel = viewModel
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        let section = sender.view?.tag ?? 0
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            guard let innings = matchDetail?.innings else { return indexPaths }
            
            for row in 0..<(innings[section].batsmen.count + innings[section].bowlers.count + innings[section].fallofWickets.count) {
                indexPaths.append(IndexPath(row: row, section: section))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.scoreCardTableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
            isSectionSelected[sender.view?.tag ?? 0] = false
        } else {
            self.hiddenSections.insert(section)
            self.scoreCardTableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
            isSectionSelected[sender.view?.tag ?? 0] = true
        }
        scoreCardTableView.reloadData()
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension ScoreCardCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchDetail?.innings.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        if let innings = matchDetail?.innings {
            return innings[section].batsmen.count + innings[section].bowlers.count + innings[section].fallofWickets.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScreenConstant.scoreCardTableViewCell) as? ScoreCardTableViewCell {
            if let inning = matchDetail?.innings[indexPath.section], let commonPlayerArray = viewModel?.getCommonScoreCardPlayerNameArray(section: indexPath.section) {
                cell.configure(indexPath: indexPath, inning: inning, commonPlayerArray: commonPlayerArray)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ScoreCardView.loadFromNib()
        let keys = matchDetail?.teams.keys.sorted(by: <)
        let score = "\(matchDetail?.innings[section].total ?? "0")/\(matchDetail?.innings[section].wickets ?? "0") (\(matchDetail?.innings[section].overs ?? "0"))"
        view.configure(team: matchDetail?.teams[section == 0 ? (keys?.first ?? "0") : (keys?.last ?? "1")]?.nameShort ?? "", score: score, isSectionSelected: isSectionSelected[section], section: section)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        view.addGestureRecognizer(tap)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let innings = matchDetail?.innings {
            return ((indexPath.row == 0) || (indexPath.row == innings[indexPath.section].batsmen.count) || (indexPath.row == (innings[indexPath.section].batsmen.count + innings[indexPath.section].bowlers.count))) ? 75 : 50
        }
        return 50
    }
}
