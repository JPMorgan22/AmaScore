
//  CheckLogViewController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 7/28/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import UIKit
import FirebaseAuth

class CheckLogViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            
            //performSegue(withIdentifier: "isLogged", sender: self)
            print(Auth.auth().currentUser ?? " ")
        } else {
            //performSegue(withIdentifier: "needToLog", sender: self)
            print("no one logged :(")
        }
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
