//
//  ManageAccountController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/10/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase


protocol createPlayerCellDelegate : class {
    
    func buttonTapped(_ sender: UIButton)
    
}


class AddPlayersController: UITableViewController, createPlayerCellDelegate {
    
    var ref: DatabaseReference!
    var teamToAddTo: String?
    let helper = AddPlayersHelper()
    
    var passingStatsInit: [String: Any] =
        [
            "Rating": 0.0,
            "Cmp": 0,
            "Att": 0,
            "Cmp %": 0.0,
            "Yds": 0,
            "Ypg": 0.0,
            "Ypc": 0.0,
            "Lng": 0,
            "Sack": 0,
            "TD": 0,
            "Int": 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(createPlayerHeader.self, forCellReuseIdentifier: "headerCell")
        self.tableView.register(createPlayerCell.self, forCellReuseIdentifier: "createPlayerCell")
        
        ref = Database.database().reference()
        
        navTabSetup()
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
   
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if (indexPath.row == 0) {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! createPlayerHeader
            return headerCell
        
        }
        else {
            
            let createPlayerCell = tableView.dequeueReusableCell(withIdentifier: "createPlayerCell", for: indexPath) as! createPlayerCell
            
            createPlayerCell.createPlayerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            return createPlayerCell
        
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.row) == 0 {
            
            return 75
            
        }
        else {
            
            return 240
       
        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        if let indexPath = getCurrentCellIndexPath(sender) {
            
            if let cell = tableView.cellForRow(at: indexPath) as? createPlayerCell {
                
                if (cell.firstNameField.text?.isEmpty)! || (cell.lastNameField.text?.isEmpty)! {
        
                    print("Please enter first and Last Name")
        
                }
                else if ((cell.primaryPositionField.text?.elementsEqual("Primary Position"))! || (cell.secondaryPositionField.text?.elementsEqual("Secondary Position"))!) {
        
                    print("Please enter positions played")
        
                }
                else {
        
                    print("creating player Struct")
        
                    let playerName = ("\(cell.firstNameField.text!) \(cell.lastNameField.text!)")
                    let playerProfile = "nil"
                    let playerNumber = (Int(cell.numberField.text ?? "N/A") ?? 0)
                    let playerPrimaryPosition = (cell.primaryPositionField.text ?? "N/A")
                    let playerSecondaryPosition = (cell.secondaryPositionField.text ?? "N/A")
                    let playerHeight = (cell.heightField.text ?? "N/A")
                    let playerWeight = (Int(cell.weightField.text ?? "N/A") ?? 0)
                    
                    let newPlayer = FootballPlayerStruct(name: playerName, profile: playerProfile, number: playerNumber, primaryPosition: playerPrimaryPosition, secondaryPosition: playerSecondaryPosition, height: playerHeight, weight: playerWeight)

                    helper.createPlayer(teamToAddTo!, newPlayer)
                    
                }
            
            }
            
        }
        
    }
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            
            return indexPath
            
        }
        return nil
        
    }
    
    
    func navTabSetup() {
        
        navigationItem.title = "Add Players"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelTapped))
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
        viewIfLoaded?.backgroundColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationItem.setHidesBackButton(true, animated: true)
        self.tableView.separatorColor = UIColor.darkGray
        
    }
    
    @objc func cancelTapped(sender: UIBarButtonItem!) {
    
        navigationController?.popToRootViewController(animated: true)
    
    }

}


class createPlayerHeader: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let createPlayerLabel: UILabel = {
    
        let label = UILabel()
        label.text = "Create Player"
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        
        addSubview(createPlayerLabel)
        
        createPlayerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -70).isActive = true
        createPlayerLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        createPlayerLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        createPlayerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
}


class createPlayerCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    weak var cellDelegate: createPlayerCellDelegate?
    
    let positions = ["QB", "RB", "FB", "WR", "TE", "C", "G", "T", "FS", "SS", "CB", "OLB", "MLB", "DE", "DT", "K", "P", "LS", "KR", "PR"]
    
    var ref: DatabaseReference!
    
    var teamName: String?
    var teamDescription: String?
    var admin: String?
    var primaryPositionSelected = String()
    var secondaryPositionSelected = String()
    
    var indexPathForCell: IndexPath?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.isUserInteractionEnabled = false
        print("setting up main views")
        setUpViews()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setUpViews() {
        
        createPickers()
        
        addSubview(firstNameField)
        addSubview(lastNameField)
        addSubview(numberField)
        addSubview(primaryPositionField)
        addSubview(secondaryPositionField)
        addSubview(heightField)
        addSubview(weightField)
        addSubview(createPlayerButton)
        
        
        firstNameField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        firstNameField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80).isActive = true
        firstNameField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        lastNameField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +75).isActive = true
        lastNameField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80).isActive = true
        lastNameField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        numberField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        numberField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40).isActive = true
        numberField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        primaryPositionField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +75).isActive = true
        primaryPositionField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40).isActive = true
        primaryPositionField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        secondaryPositionField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        secondaryPositionField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        secondaryPositionField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        heightField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +75).isActive = true
        heightField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        heightField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        weightField.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -100).isActive = true
        weightField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: +40).isActive = true
        weightField.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        createPlayerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: +20).isActive = true
        createPlayerButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: +80).isActive = true
        createPlayerButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
    }
    
    func createPickers() {
        
        let primaryPositionPicker = UIPickerView()
        let secondaryPositionPicker = UIPickerView()
        primaryPositionPicker.tag = 1
        secondaryPositionPicker.tag = 2
        primaryPositionPicker.delegate = self
        secondaryPositionPicker.delegate = self
        primaryPositionPicker.backgroundColor = scoreScoutColors.white
        secondaryPositionPicker.backgroundColor = scoreScoutColors.white
       
        primaryPositionField.inputView = primaryPositionPicker
        secondaryPositionField.inputView = secondaryPositionPicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = scoreScoutColors.lightGray
        toolBar.tintColor = UIColor.white
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(removeKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        primaryPositionField.inputAccessoryView = toolBar
        secondaryPositionField.inputAccessoryView = toolBar
   
    }
    
    
    @objc func removeKeyboard(sender: UIBarButtonItem!) {
        
        if (primaryPositionField.isEditing) {
            primaryPositionField.endEditing(true)
        }
        else {
            secondaryPositionField.endEditing(true)
        }
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return positions.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return positions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1 {
            
            primaryPositionSelected = positions[row]
            primaryPositionField.text = positions[row]
            
        }
        else {
            
            secondaryPositionSelected = positions[row]
            secondaryPositionField.text = positions[row]
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
        
        label.textColor = UIColor.black
        label.textAlignment = .center
        
        if pickerView.tag == 1{
            
            label.text = positions[row]
            
        }
        else{
            label.text = positions[row]
        }
        
        return label
    }
    
    
    let firstNameField: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.textFieldForBlackBackground(underlineField: field)
        field.attributedPlaceholder = NSAttributedString(string:"First Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        return field
    
    }()
    
    let lastNameField: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.textFieldForBlackBackground(underlineField: field)
        field.attributedPlaceholder = NSAttributedString(string:"Last Name", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        return field
        
    }()
    
    let numberField: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.textFieldForBlackBackground(underlineField: field)
        field.attributedPlaceholder = NSAttributedString(string: "Number", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        field.keyboardType = UIKeyboardType.numberPad
        return field
        
    }()
    
    let primaryPositionField: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.textFieldForBlackBackground(underlineField: field)
        field.attributedPlaceholder = NSAttributedString(string: "Primary Position", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        return field
        
    }()
    
    let secondaryPositionField: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.textFieldForBlackBackground(underlineField: field)
        field.attributedPlaceholder = NSAttributedString(string: "Secondary Position", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        return field
   
    }()
    
    let heightField: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.textFieldForBlackBackground(underlineField: field)
        field.attributedPlaceholder = NSAttributedString(string: "Height (Optional)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        return field
        
    }()
    
    let weightField: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.textFieldForBlackBackground(underlineField: field)
        field.attributedPlaceholder = NSAttributedString(string: "Weight (Optional)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        field.keyboardType = UIKeyboardType.numberPad
        return field
        
    }()
    
    let createPlayerButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Add Player Bitch", for: UIControlState.normal)
        button.setTitleColor(UIColor.green, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
        
    }()
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        print("Button pressed!!!!!!")
        cellDelegate?.buttonTapped(sender)
        
    }

}



