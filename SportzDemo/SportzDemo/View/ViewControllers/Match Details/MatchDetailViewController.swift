//
//  MatchDetailViewController.swift
//  SportzDemo
//
//  Created by Neosoft on 04/01/23.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: MatchDetailsViewModel?
    
    private var previousIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    // MARK: - setupUI()
    func setupUI() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: ScreenConstant.squadsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ScreenConstant.squadsCollectionViewCell)
        collectionView.register(UINib(nibName: ScreenConstant.infoCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ScreenConstant.infoCollectionViewCell)
        collectionView.register(UINib(nibName: ScreenConstant.scoreCardCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: ScreenConstant.scoreCardCollectionViewCell)
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        switch selectedIndex {
        case CollectionCellType.info.rawValue:
            collectionView.scrollToItem(at: IndexPath(item: CollectionCellType.info.rawValue, section: 0), at: scrollToPosition(selectedIndex), animated: true)
        case CollectionCellType.squad.rawValue:
            collectionView.scrollToItem(at: IndexPath(item: CollectionCellType.squad.rawValue, section: 0), at: scrollToPosition(selectedIndex), animated: true)
        case CollectionCellType.scorecard.rawValue:
            collectionView.scrollToItem(at: IndexPath(item: CollectionCellType.scorecard.rawValue, section: 0), at: scrollToPosition(selectedIndex), animated: true)
        default:
            break
        }
        previousIndex = selectedIndex
    }
    
    func scrollToPosition(_ selectedIndex: Int) -> UICollectionView.ScrollPosition {
        return previousIndex > selectedIndex ? .left : .right
    }
    
    @IBAction func backButtonAction(_ sender: UIButton)  {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MatchDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionCellType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case CollectionCellType.info.rawValue:
            if let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenConstant.infoCollectionViewCell, for: indexPath) as? InfoCollectionViewCell {
                if let matchDetail = viewModel?.matchDetail, let info  = viewModel?.getInfoModel() {
                    infoCell.configure(matchDetail: matchDetail, info: info)
                }
                return infoCell
            }
        case CollectionCellType.squad.rawValue:
            if let squadCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenConstant.squadsCollectionViewCell, for: indexPath) as? SquadsCollectionViewCell {
                if let matchDetail = viewModel?.matchDetail {
                    squadCell.configure(teamDetail: matchDetail.teams)
                }
                squadCell.delegate = self
                return squadCell
            }
        case CollectionCellType.scorecard.rawValue:
            if let scoreCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenConstant.scoreCardCollectionViewCell, for: indexPath) as? ScoreCardCollectionViewCell {
                if let matchDetail = viewModel?.matchDetail, let viewModel = viewModel {
                    scoreCardCell.configure(matchDetail: matchDetail, viewModel: viewModel)
                }
                return scoreCardCell
            }
        default:
            break
        }
        return UICollectionViewCell()
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let translation = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
            if translation.x > 0 {
                if previousIndex > 0 {
                    previousIndex -= 1
                }
            } else {
                if previousIndex < CollectionCellType.allCases.count - 1 {
                    previousIndex += 1
                }
            }
        targetContentOffset.pointee.x = scrollView.frame.width * CGFloat(previousIndex)
        segmentControl.selectedSegmentIndex = previousIndex
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MatchDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}

// MARK: - SquadDelegate
extension MatchDetailViewController: SquadDelegate {
    func didTapOnCell(_ player: Player) {
        let alert = UIAlertController(title: "SPORTZ", message: "Player Name: \(player.nameFull) \n Batting Style: \(player.batting.style.rawValue) \n Bowling Style: \(player.bowling.style == "" ? "N/A" : player.bowling.style)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
