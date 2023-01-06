//
//  APIManager.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

import Foundation

enum ApiMethodType: String {
    case get = "GET"
    case post = "POST"
}

enum APIManager {
   
    case getINDvNZMatchData
    case getSAvPAKMatchData
    
    var apiMethod : String {
        switch self {
        case .getINDvNZMatchData, .getSAvPAKMatchData:
            return ApiMethodType.get.rawValue
        }
    }
    
    var getUrl: URL {
        var url = ""
        switch self {
        case .getINDvNZMatchData:
            url = "/nzin01312019187360.json"
            
        case .getSAvPAKMatchData:
            url = "/sapk01222019186652.json"
        }
        return URL(string: ScreenConstant.baseURL + url)!
    }
}
