//
//  MatchDetailViewController.swift
//  SportzDemo
//
//  Created by Neosoft on 04/01/23.
//

import UIKit

class MatchDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
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
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case CollectionCellType.info.rawValue:
            if let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenConstant.infoCollectionViewCell, for: indexPath) as? InfoCollectionViewCell {
                return infoCell
            }
        case CollectionCellType.squad.rawValue:
            if let squadCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenConstant.squadsCollectionViewCell, for: indexPath) as? SquadsCollectionViewCell {
                squadCell.delegate = self
                return squadCell
            }
        case CollectionCellType.scorecard.rawValue:
            if let scoreCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenConstant.scoreCardCollectionViewCell, for: indexPath) as? ScoreCardCollectionViewCell {
                return scoreCardCell
            }
        default:
            break
        }
        return UICollectionViewCell()
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
    func didTapOnCell(_ index: Int, _ isFirtTeam: Bool) {
        let alert = UIAlertController(title: "SPORTZ", message: "Player Name: Dinesh arthuk \n Batting Style: RHB \n Bowling Style: N/A", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}


enum CollectionCellType: Int, CaseIterable {
    case info
    case squad
    case scorecard
}
