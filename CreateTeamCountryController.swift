//
//  CreateTeamCountryController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/2/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import UIKit


class CreateTeamCountryController: UIViewController {
    
    
    var teamName: String?
    
    let teamCountryLabel: UILabel = {
        let label = UILabel()
        label.text = "Where is your team located?:"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Kefa-Regular", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamCountryUSAButton: UIButton = {
        
        let button = UIButton()
        //button.tintColor = UIColor.white
        button.setTitle("USA", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navTabSetup()
        
        view.addSubview(teamCountryLabel)
        view.addSubview(teamCountryUSAButton)
        setUpView()
        
        print(teamName ?? " ")
        
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let stateSelector = USAStatePickerController()
        stateSelector.teamName = teamName
        navigationController?.pushViewController(stateSelector, animated: true)
        
    }
    
    private func setUpView() {
        
        teamCountryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamCountryLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        teamCountryLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        teamCountryLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        teamCountryUSAButton.topAnchor.constraint(equalTo: teamCountryLabel.bottomAnchor, constant: 15).isActive = true
        teamCountryUSAButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        teamCountryUSAButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        //teamCountryUSAButton.widthAnchor.constraint(equalToConstant: 100)
        //teamCountryUSAButton.heightAnchor.constraint(equalToConstant: 100)
        
    }
    
    func navTabSetup() {
        
        let NavTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        viewIfLoaded?.backgroundColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
        tabBarController?.tabBar.barTintColor = UIColor.black
        tabBarController?.tabBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = NavTextAttributes
        navigationItem.title = "New Team"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        
    }

}
    



