//
//  ThirdViewController.swift
//  Score and Scout
//
//  Created by Sarah Morgan on 7/22/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class AddPlayersViewController: UIViewController {

    
    var ref: DatabaseReference!
    let playerInitBasicBattingStats = [
        "G": 0,
        "PA": 0,
        "AB": 0,
        "H": 0,
        "Avg": 0.000,
        "R": 0,
        "2B": 0,
        "3B": 0,
        "HR": 0,
        "RBI": 0,
        "SB": 0,
        "CS": 0,
        "BB": 0,
        "SO": 0,
        "OBP": 0.000,
        "SLG": 0.000,
        "OPS": 0.000,
        "TB": 0,
        "GDP": 0,  //Grounded into DP
        "HBP": 0,  //Hit by Pitch
        "SAB": 0,  //Sac Bunts
        "SF": 0,   //Sac Fly
        "IBB": 0,  //Intentional Walks
    ]
    
    let playerInitBasicPitchingStats = [
        "W": 0,
        "L": 0,
        "W-L%": 0.000,
        "ERA": 0.00,
        "GP": 0,  //Games played
        "GS": 0,  //Games started
        "IP": 0.0,  // Innings pitched
        "CG": 0,  //Complete Game
        "SHO": 0,  //Shutouts
        "SV": 0,  //Saves
        "SVO": 0,  //Save Opportunities
        "SV%": 0.000,  //Save Percentage
        "H": 0,
        "R": 0,
        "ER": 0,
        "HR": 0,
        "BB": 0,
        "WHIP": 0.000,
        "IBB": 0,  //Intentional Walks
        "SO": 0,   //Strike-outs
        "HBP": 0,  //Hit-by-pitch
        "BK": 0,  //Balks
        "WP": 0,  //Wild pitches
        "BF": 0,  //Batters faced
        "H9": 0.0,  //Hits per 9
        "HR9": 0.0,  //HR per 9
        "BB9": 0.0,  //BB per 9
        "SO9": 0.0 ,  //Strike-out per 9
    ]
    
    @IBOutlet weak var PlayerFirstNameField: UITextField!
    @IBOutlet weak var PlayerLastNameField: UITextField!
    
    @IBAction func ConfirmAddPlayerButton(_ sender: Any) {
    
        let name = "\(PlayerFirstNameField.text!) \(PlayerLastNameField.text!)"
        
        self.ref.child("TX_Hs_Player_Stats").child("Dawson Eagles001").child(name).setValue(playerInitBasicBattingStats)
        
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
