//
//  ServiceAPI.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

// MARK: - APIResult
typealias APIResponse = (Result<MatchDetailResponse, Error>)

class ServiceAPI {
    let networkManager = NetworkManager.shared
    
    func getMatchDetails(apiMethod: APIManager, completion: @escaping (APIResponse) -> ()) {
        networkManager.apiCall(requstMethod: apiMethod) { [weak self] result in
            guard let _ = self else { return }
            switch result {
            case .success(let data):
                if let response = parseData(data: data, model: MatchDetailResponse.self) {
                    completion(.success(response))
                } else {
                    completion(.failure(CustomError.notParseModel))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

