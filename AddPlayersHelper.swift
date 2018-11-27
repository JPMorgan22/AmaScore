//
//  AddPlayersHelper.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 9/6/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import FirebaseDatabase

class AddPlayersHelper {
    
    var ref = Database.database().reference()
    
    func createPlayer(_ teamToAddTo: String, _ newPlayer: FootballPlayerStruct) {
        
        //add created player and their stats (all initialized to 0) to firebase
        let playerStats = PlayerStatsStruct()
        let id = self.ref.child("Football").child("Player Stats").child(teamToAddTo).childByAutoId()
        ref.child("Football").child("Player Stats").child(teamToAddTo).child(id.key).setValue(playerStats.dictionary)
        ref.child("Football").child("Players").child(teamToAddTo).child(id.key).setValue(newPlayer.dictionary)
        ref.child("Football").child("Rosters").child(teamToAddTo).child(newPlayer.primaryPosition!).child(id.key).setValue(newPlayer.dictionary)
        ref.child("Football").child("Rosters").child(teamToAddTo).child(newPlayer.secondaryPosition!).child(id.key).setValue(newPlayer.dictionary)
        
        
    }
    
    
}
