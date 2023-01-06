//
//  ViewController.swift
//  SportzDemo
//
//  Created by Neosoft on 04/01/23.
//

import UIKit

class MatchCenterViewController: UIViewController {

    @IBOutlet weak var matchTableView: UITableView!
    var viewModel: MatchCenterViewModel?
    var isAscending = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MatchCenterViewModel(delegate: self)
        setupUI()
    }
    
    // MARK: - setupUI()
    func setupUI() {
        navigationController?.navigationBar.isHidden = true
        matchTableView.delegate = self
        matchTableView.dataSource = self
        matchTableView.register(UINib(nibName: ScreenConstant.matchCenterTableViewCell, bundle: nil), forCellReuseIdentifier: ScreenConstant.matchCenterTableViewCell)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MatchCenterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ScreenConstant.matchCenterTableViewCell) as? MatchCenterTableViewCell {
            if let matchDetail = viewModel?.getMatchDetal(index: indexPath.row, isAsc: isAscending) {
                cell.configureCell(matchDetail: matchDetail)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: ScreenConstant.matchDetailViewController, bundle: nil)
        if let matchDetailVC = storyboard.instantiateViewController(withIdentifier: ScreenConstant.matchDetailViewController) as? MatchDetailViewController {
            matchDetailVC.viewModel = MatchDetailsViewModel(matchDetail: viewModel?.getMatchDetal(index: indexPath.row, isAsc: isAscending))
            self.navigationController?.pushViewController(matchDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MatchCenterHeader.loadFromNib()
        headerView.delegate = self
        headerView.configure(isAscending: isAscending)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

// MARK: - MatchCenterProtocol
extension MatchCenterViewController: MatchCenterProtocol {
    func didCallAPI() {
        matchTableView.reloadData()
    }
}

// MARK: - MatchCenterHeaderDelegate
extension MatchCenterViewController: MatchCenterHeaderDelegate {
    func didSelectSorting(isAcsending: Bool) {
        self.isAscending = isAcsending
        matchTableView.reloadData()
    }
}
