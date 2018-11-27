//
//  CreateTeamNameController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/1/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import UIKit

class CreateTeamNameController: UIViewController, UITextFieldDelegate {
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "New Team's Name:"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Kefa-Regular", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamNameField: UITextField = {
        
        let teamNameField =  UnderlineTextField()
        teamNameField.attributedPlaceholder = NSAttributedString(string:"Ex: Permian Panthers", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        teamNameField.font = UIFont.systemFont(ofSize: 19)
        teamNameField.textColor = UIColor.white
        teamNameField.autocorrectionType = UITextAutocorrectionType.no
        teamNameField.keyboardType = UIKeyboardType.default
        teamNameField.returnKeyType = UIReturnKeyType.done
        teamNameField.clearButtonMode = UITextFieldViewMode.whileEditing;
        teamNameField.translatesAutoresizingMaskIntoConstraints = false
        teamNameField.tintColor = UIColor.white
        teamNameField.textAlignment = .center
        return teamNameField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTabSetup()
        teamNameField.delegate = self
        
        view.addSubview(teamNameLabel)
        view.addSubview(teamNameField)
        setUpView()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    private func setUpView() {
        
        teamNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -175).isActive = true
        teamNameLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        teamNameLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        teamNameLabel.textAlignment = .center
        
        teamNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamNameField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -135).isActive = true
        teamNameField.widthAnchor.constraint(equalToConstant: 275).isActive = true
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.tintColor = UIColor.green
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.tintColor = UIColor.green
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let teamCountryController = CreateTeamCountryController()
        let playerController = createPlayerCell()
        teamCountryController.teamName = textField.text
        playerController.teamName = textField.text
        navigationController?.pushViewController(teamCountryController, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

