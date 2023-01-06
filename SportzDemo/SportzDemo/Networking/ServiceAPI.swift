//
//  ServiceAPI.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

class ServiceAPI {
    let networkManager = NetworkManager.shared
    
    func getMatchDetails(apiMethod: APIManager, completion: @escaping (Result<MatchDetailResponse, Error>) -> ()) {
        networkManager.apiCall(requstMethod: apiMethod) { result in
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

