//
//  SquadsCollectionViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 04/01/23.
//

import UIKit

class SquadsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var squadTableView: UITableView!
    
    weak var delegate: SquadDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    // MARK: - setupUI
    func setupUI() {
        squadTableView.delegate = self
        squadTableView.dataSource = self
        squadTableView.register(UINib(nibName: "SquadTableViewCell", bundle: nil), forCellReuseIdentifier: "SquadTableViewCell")
    }
}

// MARK:  - UITableViewDelegate, UITableViewDataSource
extension SquadsCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        11
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "SquadTableViewCell") as? SquadTableViewCell {
            cell.configure(index: indexPath.item, delegate: self)
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
        label.text = "PLAYING XI"
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
    func didTapOnCell(_ index: Int, _ isFirtTeam: Bool) {
        delegate?.didTapOnCell(index, isFirtTeam)
    }
}
