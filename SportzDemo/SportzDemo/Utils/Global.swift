//
//  Global.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

func parseData<T: Codable>(data: Data, model: T.Type) -> T? {
    do {
        let data = try JSONDecoder().decode(T.self, from: data)
        return data
    }
    
    catch let error {
        print(error.localizedDescription)
    }
    return nil
}

enum CustomError: String, Error {
    case notParseModel = "Model not parse"
    case apiFailed = "API Failed"
}

enum CollectionCellType: Int, CaseIterable {
    case info
    case squad
    case scorecard
}

enum Info: String, CaseIterable {
    case Match
    case Series
    case Date
    case Time
    case Venue
    case Umpires
    case Referee
    case Stadium
    case SeriesStatus = "Series Status"
    case PlayerOfTheMatch = "Player Of The Match"
}

