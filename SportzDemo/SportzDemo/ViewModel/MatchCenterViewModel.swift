//
//  MatchCenterViewModel.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

protocol MatchCenterProtocol: AnyObject {
    func didCallAPI()
    func didApiFailed(error: String)
}

class MatchCenterViewModel {
    
    let service = ServiceAPI()
    let group = DispatchGroup()
    
    var responseList = [MatchDetailResponse]()
    weak var delegate: MatchCenterProtocol?
    
    init(delegate: MatchCenterProtocol) {
        self.delegate = delegate
        allApiCall()
    }
    
    func getIndVNZMatchData() {
        service.getMatchDetails(apiMethod: .getINDvNZMatchData) { [weak self] result in
            guard let strongself = self else { return }
            switch result {
            case .success(let model):
                strongself.responseList.append(model)
            case .failure(let error):
                strongself.delegate?.didApiFailed(error: error.localizedDescription)
            }
            strongself.group.leave()
        }
    }
    
    func getPKVSAMatchData() {
        service.getMatchDetails(apiMethod: .getSAvPAKMatchData) { [weak self] result in
            guard let strongself = self else { return }
            switch result {
            case .success(let model):
                strongself.responseList.append(model)
            case .failure(let error):
                strongself.delegate?.didApiFailed(error: error.localizedDescription)
            }
            strongself.group.leave()
        }
    }
    
    func allApiCall() {
        group.enter()
        getIndVNZMatchData()
        
        group.enter()
        getPKVSAMatchData()
        
        group.notify(queue: .main) { [weak self] in
            guard let strongself = self else { return }
            strongself.delegate?.didCallAPI()
        }
    }
    
    func numberOfRows() -> Int {
        return responseList.count
    }
    
    func getMatchDetal(index: Int, isAsc: Bool) -> MatchDetailResponse {
        if isAsc {
            return responseList.sorted(by: { $0.matchdetail.match.date < $1.matchdetail.match.date })[index]
        }
        return responseList.sorted(by: { $0.matchdetail.match.date > $1.matchdetail.match.date })[index]
    }
}
