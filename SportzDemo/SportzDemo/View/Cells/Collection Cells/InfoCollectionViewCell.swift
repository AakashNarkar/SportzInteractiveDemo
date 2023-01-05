//
//  InfoCollectionViewCell.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var infoTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    func setupUI() {
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.register(UINib(nibName: ScreenConstant.infoTableViewCell, bundle: nil), forCellReuseIdentifier: ScreenConstant.infoTableViewCell)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension InfoCollectionViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScreenConstant.infoTableViewCell) as? InfoTableViewCell {
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
