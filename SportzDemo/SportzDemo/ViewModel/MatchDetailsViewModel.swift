//
//  MatchDetailsViewModel.swift
//  SportzDemo
//
//  Created by Neosoft on 05/01/23.
//

import Foundation

class MatchDetailsViewModel {
    var matchDetail: MatchDetailResponse?
    
    init(matchDetail: MatchDetailResponse?) {
        self.matchDetail = matchDetail
    }
    
    func getInfoModel() -> [InfoModel] {
        return [
            InfoModel(infoName: Info.Match.rawValue, infoValue: matchDetail?.matchdetail.match.number ?? ""),
            InfoModel(infoName: Info.Series.rawValue, infoValue: matchDetail?.matchdetail.series.name ?? ""),
            InfoModel(infoName: Info.Date.rawValue, infoValue: matchDetail?.matchdetail.match.date ?? ""),
            InfoModel(infoName: Info.Time.rawValue, infoValue: matchDetail?.matchdetail.match.time ?? ""),
            InfoModel(infoName: Info.Venue.rawValue, infoValue: matchDetail?.matchdetail.venue.name ?? ""),
            InfoModel(infoName: Info.Umpires.rawValue, infoValue: matchDetail?.matchdetail.officials.umpires ?? ""),
            InfoModel(infoName: Info.Referee.rawValue, infoValue: matchDetail?.matchdetail.officials.referee ?? ""),
            InfoModel(infoName: Info.Stadium.rawValue, infoValue:  matchDetail?.matchdetail.venue.name ?? ""),
            InfoModel(infoName: Info.SeriesStatus.rawValue, infoValue:  matchDetail?.matchdetail.status ?? ""),
            InfoModel(infoName: Info.PlayerOfTheMatch.rawValue, infoValue:  matchDetail?.matchdetail.playerMatch ?? ""),
        ]
    }
}
