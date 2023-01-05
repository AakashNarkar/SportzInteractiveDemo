//
//  ScoreCardCollectionViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class ScoreCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var scoreCardTableView: UITableView!
    
    var hiddenSections = Set<Int>()
    var teams = [
        ScoreCardModel(teamName: "IND", batter: ["Rohit", "Kohli"], extras: "2", total: "3", bowler: ["Hardik", "Shami"], fallOfWickets: ["Rohit", "Kohli"], isExpanded: false),
        ScoreCardModel(teamName: "NZ", batter: ["Root", "Boot"], extras: "2", total: "3", bowler: ["Hardik", "Shami"], fallOfWickets: ["Root", "BBoot"], isExpanded: false)
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       setupUI()
    }
    
    func setupUI() {
        scoreCardTableView.delegate = self
        scoreCardTableView.dataSource = self
        scoreCardTableView.register(UINib(nibName: ScreenConstant.scoreCardTableViewCell, bundle: nil), forCellReuseIdentifier: ScreenConstant.scoreCardTableViewCell)
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        let section = sender.view?.tag ?? 0
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.teams[section].batter.count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.scoreCardTableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.scoreCardTableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
}

// MARK: -  UITableViewDelegate, UITableViewDataSource
extension ScoreCardCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        teams.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.hiddenSections.contains(section) {
            return 0
        }
        return teams[section].batter.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScreenConstant.scoreCardTableViewCell) as? ScoreCardTableViewCell {
            cell.batterView.isHidden = indexPath.row != 0
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ScoreCardView.loadFromNib()
        view.tag = section
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction(sender:)))
        view.addGestureRecognizer(tap)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 0 ? 75 : 50
    }
}

struct ScoreCardModel {
    var teamName: String
    var batter: [String]
    var extras: String
    var total: String
    var bowler: [String]
    var fallOfWickets: [String]
    var isExpanded: Bool
}

enum Ssection: Int {
    case teamA
    case teamB
}
