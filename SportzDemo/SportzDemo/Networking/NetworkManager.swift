//
//  NetworkManager.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func apiCall(requstMethod: APIManager, completion: @escaping (Result<Data, Error>) -> ()) {
        var urlRequest = URLRequest(url: requstMethod.getUrl)
        urlRequest.httpMethod = requstMethod.apiMethod
        
        CustomLoader.sharedInstance.showLoader()
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            CustomLoader.sharedInstance.removeLoader()
            if let data = data , error == nil , let respo = response as? HTTPURLResponse {
                if respo.statusCode >= 200 , respo.statusCode <= 300 {
                    completion(.success(data))
                } else {
                    completion(.failure(error ?? CustomError.apiFailed))
                }
            } else {
                completion(.failure(error ?? CustomError.apiFailed))
            }
        }.resume()
    }
}
