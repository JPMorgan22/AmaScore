//
//  USAStatePickController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/3/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class USAStatePickerController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var ref: DatabaseReference!
    
    let states = ["Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Deleware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virgina", "Washington", "West Virginia", "Wisconsin", "Wyoming"]
    
    let divisions = ["5AD1", "5AD2", "4AD1", "4AD2"]
    
    var stats = ["Name": String(), "Description": String()]
    
    var stateSelected: String?
    var divisionSelected: String?
    
    var teamName: String?
    
    let teamStateField: UITextField = {
        
        let field =  UnderlineTextField()
        field.font = UIFont.systemFont(ofSize: 19)
        field.text = "Select State"
        field.textAlignment = .center
        field.textColor = UIColor.white
        field.autocorrectionType = UITextAutocorrectionType.no
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextFieldViewMode.whileEditing;
        field.translatesAutoresizingMaskIntoConstraints = false
        field.tintColor = UIColor.white
        return field
    }()
    
    let teamStateLabel: UILabel = {
        let label = UILabel()
        label.text = "Team's State"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Kefa-Regular", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamDivisionField: UITextField = {
        
        let field =  UnderlineTextField()
        field.font = UIFont.systemFont(ofSize: 19)
        field.text = "Select Division"
        field.textAlignment = .center
        field.textColor = UIColor.white
        field.autocorrectionType = UITextAutocorrectionType.no
        field.keyboardType = UIKeyboardType.default
        field.returnKeyType = UIReturnKeyType.done
        field.clearButtonMode = UITextFieldViewMode.whileEditing;
        field.translatesAutoresizingMaskIntoConstraints = false
        field.tintColor = UIColor.white
        return field
    }()
    
    let teamDivisionLabel: UILabel = {
        let label = UILabel()
        label.text = "Team's Division"
        label.textColor = UIColor.white
        label.font = UIFont(name: "Kefa-Regular", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Team", for: UIControlState.normal)
        button.setTitleColor(UIColor.green, for: UIControlState.normal)
        button.addTarget(self, action: #selector(createTeamTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTabSetup()
        createPickers()
        createToolBar()
        
        view.addSubview(teamStateLabel)
        view.addSubview(teamStateField)
        
        view.addSubview(teamDivisionLabel)
        view.addSubview(teamDivisionField)

        view.addSubview(doneButton)
        
        setUpView()
        ref = Database.database().reference()
        
        print(teamName ?? "oops")
    }
    
    fileprivate func createPickers() {

        let statePicker = UIPickerView()
        let divisionPicker = UIPickerView()
        statePicker.tag = 1
        divisionPicker.tag = 2
        statePicker.delegate = self
        divisionPicker.delegate = self
        statePicker.backgroundColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
        divisionPicker.backgroundColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
        teamStateField.inputView = statePicker
        teamDivisionField.inputView = divisionPicker
    }

    fileprivate func createToolBar() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        toolBar.barTintColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
        toolBar.tintColor = UIColor.gray
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(USAStatePickerController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        teamStateField.inputAccessoryView = toolBar
        teamDivisionField.inputAccessoryView = toolBar
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       
        if pickerView.tag == 1 {
            return states.count
        }
        else {
            return divisions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView.tag == 1 {
            return states[row]
        }
        else {
            return divisions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            stateSelected = states[row]
            teamStateField.text = states[row]
        }
        else {
            divisionSelected = divisions[row]
            teamDivisionField.text = divisions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var label = UILabel()
        
        if let view = view as? UILabel {
            label = view
        }
        else {
            label = UILabel()
        }
        
        label.textColor = UIColor.white
        label.textAlignment = .center
        
        if pickerView.tag == 1{
            
            label.text = states[row]
            
        }
        else{
            
            label.text = divisions[row]
        
        }
        
        return label
    }
    
    @objc func createTeamTapped(sender: UIButton!) {
        
        if (teamStateField.text?.elementsEqual("Select State"))! || ((teamDivisionField).text?.elementsEqual("Select Division"))! {
            print("plese fill all boxes!")
        }
        else {
            
            let teamDescription = ("\(stateSelected!) \(divisionSelected!)")
            let adminName = (Auth.auth().currentUser?.displayName ?? " ")
            let adminUID = (Auth.auth().currentUser?.uid ?? " ")
            let adminDict = [adminName: adminUID]
            
            let newTeam = Team(name: teamName ?? "No Name Given", description: teamDescription)
            print(newTeam)
            print(newTeam.dictionary)
            
            let id = self.ref.child("Football").child("Teams").childByAutoId()
            //let stats = ["Team Name": teamName, "Description": teamDescription]
            let searchValues = ["Description": teamDescription, "ID": id.key]
            print("team created")
            print(id.key)
            self.ref.child("Football").child("Teams").child(id.key).setValue(newTeam.dictionary)
            self.ref.child("Search Teams").child(teamName!).setValue(searchValues)
            self.ref.child("Football").child("Admins").child(id.key).setValue(adminDict)
            
            let addPlayerController = AddPlayersController()
            addPlayerController.teamToAddTo = id.key
            navigationController?.pushViewController(addPlayerController, animated: true)
        }
        
    }
        
    
    private func setUpView() {
        

        teamStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -175).isActive = true
        teamStateLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        teamStateLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        teamStateLabel.textAlignment = .center


        teamStateField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamStateField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -135).isActive = true
        teamStateField.widthAnchor.constraint(equalToConstant: 200)

        teamDivisionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamDivisionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40).isActive = true
        teamDivisionLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        teamDivisionLabel.heightAnchor.constraint(equalToConstant: 75).isActive = true
        teamDivisionLabel.textAlignment = .center

        teamDivisionField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamDivisionField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 10).isActive = true
        teamDivisionField.widthAnchor.constraint(equalToConstant: 200)

        doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        doneButton.widthAnchor.constraint(equalToConstant: 200)
        
        
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
