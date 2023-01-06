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
            InfoModel(infoName: Info.Date.rawValue, infoValue: matchDetail?.matchdetail.match.date.getFormattedDate() ?? ""),
            InfoModel(infoName: Info.Time.rawValue, infoValue: matchDetail?.matchdetail.match.time ?? ""),
            InfoModel(infoName: Info.Venue.rawValue, infoValue: matchDetail?.matchdetail.venue.name ?? ""),
            InfoModel(infoName: Info.Umpires.rawValue, infoValue: matchDetail?.matchdetail.officials.umpires ?? ""),
            InfoModel(infoName: Info.Referee.rawValue, infoValue: matchDetail?.matchdetail.officials.referee ?? ""),
            InfoModel(infoName: Info.Stadium.rawValue, infoValue:  matchDetail?.matchdetail.venue.name ?? ""),
            InfoModel(infoName: Info.SeriesStatus.rawValue, infoValue:  matchDetail?.matchdetail.status ?? ""),
            InfoModel(infoName: Info.PlayerOfTheMatch.rawValue, infoValue:  matchDetail?.matchdetail.playerMatch ?? ""),
        ]
    }
    
    func getCommonScoreCardPlayerNameArray(section: Int) -> [ScoreCardModel] {
        var commonArray = [ScoreCardModel]()
        
        if let inning = matchDetail?.innings[section], let keys = matchDetail?.teams.keys {
            let keyArray = Array(keys).sorted(by: <)
            let player = matchDetail?.teams[keyArray[section]]?.players
            let opponentPlayer = matchDetail?.teams[keyArray[section == 0 ? 1 : 0]]?.players
           
            inning.batsmen.forEach { commonArray.append(ScoreCardModel(playerName: player?[$0.batsman]?.nameFull ?? "", rValue: $0.runs == "" ? "-" : $0.runs, bValue: $0.balls == "" ? "-" : $0.balls, fourValue: $0.fours == "" ? "-" : $0.fours, sixValue: $0.sixes == "" ? "-" : $0.sixes, srValue: $0.strikerate == "" ? "-" : $0.strikerate)) }
            inning.bowlers.forEach { commonArray.append(ScoreCardModel(playerName: opponentPlayer?[$0.bowler]?.nameFull ?? "", rValue: $0.overs, bValue: $0.maidens, fourValue: $0.runs, sixValue: $0.wickets, srValue: $0.economyrate)) }
            inning.fallofWickets.forEach { commonArray.append(ScoreCardModel(playerName: player?[$0.batsman]?.nameFull ?? "", rValue: "", bValue: "", fourValue: $0.score, sixValue: "", srValue: $0.overs)) }
        }
        return commonArray
    }
}
