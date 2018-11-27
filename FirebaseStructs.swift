//
//  FirebaseStructs.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/18/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import FirebaseDatabase


protocol SerializeFirebase {
    
    init?(dictionary:[String: Any])
    
}

struct Team {
    
    var name: String
    var description: String
    
    var dictionary:[String: Any] {
    
        return [
    
            "Name": name,
            "Description": description,
    
        ]
    
    }
    
    init(snap: DataSnapshot) {

        let teamDict = snap.value as! [String: Any]

        self.name = teamDict["Name"] as! String
        self.description = teamDict["Description"] as! String

    }
    
    init(name: String, description: String) {
        
        self.name = name
        self.description = description
        
    }
    
}


struct FootballPlayerStruct {
    
    var name: String?
    var profile: String?
    var number: Int?
    var primaryPosition: String?
    var secondaryPosition: String?
    var height: String?
    var weight: Int?
    
    var dictionary: [String:Any] {
        
        return [
        
            "Name": name ?? "nil",
            "Profile Link": profile ?? "nil",
            "Number": number ?? "nil",
            "Primary Position": primaryPosition ?? "nil",
            "Secondary Positionn": secondaryPosition ?? "nil",
            "Height": height ?? "nil",
            "Weight": weight ?? "nil",
        
        ]
        
    }
    
    init(name: String, profile: String, number: Int, primaryPosition: String, secondaryPosition: String, height: String, weight: Int, passingStats: PassingStatsStruct? = nil, rushingStats: RushingStatsStruct? = nil, receivingStats: ReceivingStatsStruct? = nil, defensiveStats: DefensiveStatsStruct? = nil, kickingStats: KickingStatsStruct? = nil, returnStats: ReturnStatsStruct? = nil) {
        
        self.name = name
        self.profile = profile
        self.number = number
        self.primaryPosition = primaryPosition
        self.secondaryPosition = secondaryPosition
        self.height = height
        self.weight = weight
        
    }
    
    init?(snap: DataSnapshot) {
        
        guard let player = snap.value as? [String:Any],
            let name = player["Name"] as? String,
            let profile = player["Profile Link"] as? String,
            let number = player["Number"] as? Int,
            let primaryPosition = player["Primary Position"] as? String,
            let secondaryPosition = player["Secondary Positionn"] as? String,
            let height = player["Height"] as? String,
            let weight = player["Weight"] as? Int else {return nil}
        
            self.name = name
            self.profile = profile
            self.number = number
            self.primaryPosition = primaryPosition
            self.secondaryPosition = secondaryPosition
            self.height = height
            self.weight = weight
    }
    
    init() {
        
        self.name = "empty"
        self.profile = "empty"
        self.number = 0
        self.primaryPosition = "empty"
        self.secondaryPosition = "empty"
        self.height = "empty"
        self.weight = 0
        
    }
    
}

struct TeamOffensiveRoster {
    
    var qb: FootballPlayerStruct
    var hb1: FootballPlayerStruct?
    var hb2: FootballPlayerStruct?
    var fb: FootballPlayerStruct?
    var wr1: FootballPlayerStruct?
    var wr2: FootballPlayerStruct?
    var wr3: FootballPlayerStruct?
    var wr4: FootballPlayerStruct?
    var wr5: FootballPlayerStruct?
    var te1: FootballPlayerStruct?
    var te2: FootballPlayerStruct?
    var te3: FootballPlayerStruct?
    var c: FootballPlayerStruct
    var lg: FootballPlayerStruct
    var rg: FootballPlayerStruct
    var lt: FootballPlayerStruct
    var rt: FootballPlayerStruct
    
    var dictionary: [String: Any] {
        
        return [

            "QB": qb,
            "HB1": hb1 ?? "none",
            "HB2": hb2 ?? "none",
            "FB": fb ?? "none",
            "WR1": wr1 ?? "none",
            "WR2": wr2 ?? "none",
            "WR3": wr3 ?? "none",
            "WR4": wr4 ?? "none",
            "WR5": wr5 ?? "none",
            "TE1": te1 ?? "none",
            "TE2": te2 ?? "none",
            "C": c,
            "LG": lg,
            "RG": rg,
            "LT": lt,
            "RT": rt

        ]
    }
    
    init(qb: FootballPlayerStruct, hb1: FootballPlayerStruct, wr1: FootballPlayerStruct, wr2: FootballPlayerStruct, wr3: FootballPlayerStruct, wr4: FootballPlayerStruct, c: FootballPlayerStruct, lg: FootballPlayerStruct, rg: FootballPlayerStruct, lt: FootballPlayerStruct, rt: FootballPlayerStruct) {
        
        self.qb = qb
        self.hb1 = hb1
        self.wr1 = wr1
        self.wr2 = wr2
        self.wr3 = wr3
        self.wr4 = wr4
        self.c = c
        self.lg = lg
        self.rg = rg
        self.lt = lt
        self.rt = rt
        
    }
    
}

struct PlayerStatsStruct {
    
    var passingStats: PassingStatsStruct
    var rushingStats: RushingStatsStruct
    var receivingStats: ReceivingStatsStruct
    var defensiveStats: DefensiveStatsStruct
    var kickingStats: KickingStatsStruct
    var returnStats: ReturnStatsStruct
    
    var dictionary: [String: Any] {
        
        return [
        
            "Passing Stats": passingStats.dictionary,
            "Rushing Stats": rushingStats.dictionary,
            "Receiving Stats": receivingStats.dictionary,
            "Defensive Stats": defensiveStats.dictionary,
            "Kicking Stats": kickingStats.kickingDictionary,
            "Punting Stats": kickingStats.puntingDictionary
        
        ]
        
    }
    
    init() {
        
        self.passingStats = PassingStatsStruct()
        self.rushingStats = RushingStatsStruct()
        self.receivingStats = ReceivingStatsStruct()
        self.defensiveStats = DefensiveStatsStruct()
        self.kickingStats = KickingStatsStruct()
        self.returnStats = ReturnStatsStruct()
        
    }
    
}


struct PassingStatsStruct {
    
    //make optionals with seperate inits for simple scorekeeping
    
    var passerRating: Double
    var cmp: Int
    var att: Int
    var cmpPercent: Double
    var yds: Int
    var ypg: Double
    var ypc: Double
    var lng: Int
    var sack: Int
    var td: Int
    var ints: Int
    //3rd and long pic rate?
    
    var dictionary: [String:Any] {
        
        return [
            
            "Rating": passerRating,
            "Cmp": cmp,
            "Att": att,
            "Cmp %": cmpPercent,
            "Yds": yds,
            "Ypg": ypg,
            "Ypc": ypc,
            "Lng": lng,
            "Sack": sack,
            "TD": td,
            "Int": ints
        ]
        
    }
    
    init?(dic: [String: Any]) {
        
        guard let PassRat = dic["Rating"] as? Double,
            let Cmp = dic["Cmp"] as? Int,
            let Att = dic["Att"] as? Int,
            let CmpPercent = dic["Cmp %"] as? Double,
            let Yds = dic["Yds"] as? Int,
            let Ypg = dic["Ypg"] as? Double,
            let Ypc = dic["Ypc"] as? Double,
            let Lng = dic["Lng"] as? Int,
            let Sack = dic["Sack"] as? Int,
            let Td = dic["TD"] as? Int,
            let Ints = dic["Int"] as? Int else {
                
                
                print("Something was unable to initialize")
                return nil
        }
        
        
        self.init(passerRating: PassRat, cmp: Cmp, att: Att, cmpPercent: CmpPercent, yds: Yds, ypg: Ypg, ypc: Ypc, lng: Lng, sack: Sack, td: Td, ints: Ints)
        
    }
    
    init(passerRating: Double, cmp: Int, att: Int, cmpPercent: Double, yds: Int, ypg: Double, ypc: Double, lng: Int, sack: Int, td: Int, ints: Int){
        
        self.passerRating = passerRating
        self.cmp = cmp
        self.att = att
        self.cmpPercent = cmpPercent
        self.yds = yds
        self.ypg = ypg
        self.ypc = ypc
        self.lng = lng
        self.sack = sack
        self.td = td
        self.ints = ints
        
        }
    
    init(){
        
        self.passerRating = 0.0
        self.cmp = 0
        self.att = 0
        self.cmpPercent = 0.0
        self.yds = 0
        self.ypg = 0.0
        self.ypc = 0.0
        self.lng = 0
        self.sack = 0
        self.td = 0
        self.ints = 0
        
    }
    
    
}


struct RushingStatsStruct {
    
    var rush: Int
    var yds: Int
    var td: Int
    var lng: Int
    var ypc: Double
    var ypg: Double
    
    var dictionary: [String: Any] {
        
        return [
        
            "Rush": rush,
            "Yds": yds,
            "TD": td,
            "Lng": lng,
            "Ypc": ypc,
            "Ypg": ypg
        
        ]
        
    }
    
    init() {
        
        self.rush = 0
        self.yds = 0
        self.td = 0
        self.lng = 0
        self.ypc = 0.0
        self.ypg = 0.0
        
    }
    
    
    
}

struct ReceivingStatsStruct {
    
    var tgt: Int
    var rec: Int
    var yds: Int
    var td: Int
    var ypc: Double
    var lng: Int
    var drop: Int
    var rpg: Double
    var ypg: Double
    var catchPercent: Double
    
    var dictionary: [String: Any] {
    
        return [
        
            "Tgt": tgt,
            "Rec": rec,
            "Yds": yds,
            "TD": td,
            "Ypc": ypc,
            "Lng": lng,
            "Drop": drop,
            "Rpg": rpg,
            "Ypg": ypg,
            "Catch %": catchPercent
        
        ]
        
    }
    
    init() {
        
        self.tgt = 0
        self.rec = 0
        self.yds = 0
        self.td = 0
        self.ypc = 0.0
        self.lng = 0
        self.drop = 0
        self.rpg = 0.0
        self.ypg = 0.0
        self.catchPercent = 0.0
        
    }
    
    
    
}

struct DefensiveStatsStruct {
    
    var tkl: Int
    var ast: Int
    var tfl: Int
    var sack: Int
    var sfty: Int
    var ints: Int
    var intTd: Int
    var intYds: Int
    var intLng: Int
    var def: Int
    var ff: Int
    var fr: Int
    var frTd: Int
    
    var dictionary: [String: Any] {
        
        return [
        
            "Tkl": tkl,
            "Ast": ast,
            "Tfl": tfl,
            "Sack": sack,
            "Sfty": sfty,
            "Ints": ints,
            "IntTd": intTd,
            "IntYds": intYds,
            "IntLng": intLng,
            "Def": def,
            "FF": ff,
            "FR": fr,
            "FrTd": frTd
        
        ]
        
    }
    
    init() {
        
        self.tkl = 0
        self.ast = 0
        self.tfl = 0
        self.sack = 0
        self.sfty = 0
        self.ints = 0
        self.intTd = 0
        self.intYds = 0
        self.intLng = 0
        self.def = 0
        self.ff = 0
        self.fr = 0
        self.frTd = 0
        
    }
    
}

struct KickingStatsStruct {
    
    var fgm0: Int //between 0-19 yards
    var fga0: Int
    var fgm20: Int //20-29
    var fga20: Int
    var fgm30: Int //30-39
    var fga30: Int
    var fgm40: Int //40-49
    var fga40: Int
    var fgm50: Int //50+ yards
    var fga50: Int
    var fgm: Int  //total fgm
    var fga: Int
    var fgPercent: Double
    var lng: Int
    var xpm: Int
    var xpa: Int
    var xpPercent: Double
    
    //punting
    
    var pnt: Int
    var yds: Int
    var avg: Double
    var blk: Int
    
    var kickingDictionary: [String: Any] {
        
        return [
        
            "Fgm 0-19": fgm0,
            "Fga 0-19": fga0,
            "Fgm 20-29": fgm20,
            "Fga 20-29": fga20,
            "Fgm 30-39": fgm30,
            "Fga 30-39": fga30,
            "Fgm 40-49": fgm40,
            "Fga 40-49": fga40,
            "Fgm 50+": fgm50,
            "Fga 50+": fga50,
            "Total Fgm": fgm,
            "Total Fga": fga,
            "Fg %": fgPercent,
            "Lng": lng,
            "Xpm": xpm,
            "Xpa": xpa,
            "Xp %": xpPercent
        
        ]
        
    }
    
    var puntingDictionary: [String: Any] {
        
        return [
        
            "Pnt": pnt,
            "Yds": yds,
            "Avg": avg,
            "Blk": blk
        
        ]
        
    }
    
    init() {
        
        self.fgm0 = 0
        self.fga0 = 0
        self.fgm20 = 0
        self.fga20 = 0
        self.fgm30 = 0
        self.fga30 = 0
        self.fgm40 = 0
        self.fga40 = 0
        self.fgm50 = 0
        self.fga50 = 0
        self.fgm = 0
        self.fga = 0
        self.fgPercent = 0.0
        self.lng = 0
        self.xpm = 0
        self.xpa = 0
        self.xpPercent = 0.0
        
        self.pnt = 0
        self.yds = 0
        self.avg = 0.0
        self.blk = 0
        
    }
    
    
}

struct ReturnStatsStruct {
    
    var kRet: Int
    var kRetYds: Int
    var kRetAvg: Double
    var kRetTd: Int
    var kRetLng: Int
    
    var pRet: Int
    var pRetYds: Int
    var pRetAvg: Double
    var pRetTd: Int
    var pRetLng: Int
    
    var dictionary: [String: Any] {
        
        return [
        
        "Kr": kRet,
        "KrYds": kRetYds,
        "KrAvg": kRetAvg,
        "KrTD": kRetTd,
        "KrLng": kRetLng,
        
        "Pr": pRet,
        "PrYds": pRetYds,
        "PrAvg": pRetAvg,
        "PrTD": pRetTd,
        "PrLng": pRetLng
        
        ]
    }
    
    init() {
        
        self.kRet = 0
        self.kRetYds = 0
        self.kRetAvg = 0.0
        self.kRetTd = 0
        self.kRetLng = 0
        
        self.pRet = 0
        self.pRetYds = 0
        self.pRetAvg = 0.0
        self.pRetTd = 0
        self.pRetLng = 0
        
    }
    
}

extension Team: SerializeFirebase {
    init?(dictionary:[String: Any]) {
        
        guard let Name = dictionary["Name"] as? String,
            let Description = dictionary["Description"] as? String else {return nil}
        
        self.init(name: Name, description: Description)
        
    }
    
}


