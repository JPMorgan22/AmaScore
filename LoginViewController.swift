//
//  LoginViewController.swift
//  Score and Scout
//
//  Created by Sarah Morgan on 7/16/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FBSDKLoginKit
import FirebaseAuth

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    var ref:DatabaseReference?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view?.backgroundColor = UIColor.white
        navigationController?.navigationBar.isHidden = true
        
        print("made it")
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        view.addSubview(loginButton)
        loginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        
    }
    
    
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if error != nil {
                // ...
                return
            }
            print("Signed In")
            print(credential)
            //let layout = UICollectionViewFlowLayout()
            //let mainFeedController = MainFeedViewController(collectionViewLayout: layout)
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
            let mainFeedController = MainFeedViewController.init(collectionViewLayout: layout )
            self.navigationController?.pushViewController(mainFeedController, animated: true)
            print(Auth.auth().currentUser?.uid ?? " ")
            print(Auth.auth().currentUser?.displayName ?? " ")
            
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!){
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        print("User Logged Out")
    }
    
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

