//
//  DepthChartController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 9/6/18.
//  Copyright © 2018 Score and Scout. All rights reserved.


import Foundation
import UIKit
import FirebaseDatabase

class DepthChartController: UITableViewController, updateTableInCell {
    
    var ref = Database.database().reference()
    var playersAtPosition = [FootballPlayerStruct]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navTabSetup()
        
        self.tableView.register(depthChartHeaderCell.self, forCellReuseIdentifier: "depthChartHeaderCell")
        self.tableView.register(playerCell.self, forCellReuseIdentifier: "playerCell")
        
        ref.child("Football").child("Rosters").child("-LNvowzDLt8i7rjjds_x").child("QB").observe(.childAdded, with: { (snapshot) in
            
            let player = FootballPlayerStruct(snap: snapshot)
            self.playersAtPosition.append(player ?? FootballPlayerStruct.init())
            self.tableView.reloadData()
            self.tableView.setEditing(true, animated: true)
        
        }) { (error) in
            
            print(error.localizedDescription)
            
        }
        
    }
    
    func updateTableView(position: String) {
        
        ref.child("Football").child("Rosters").child("-LNvowzDLt8i7rjjds_x").child(position).observeSingleEvent(of: .value, with: { (snapshot) in

            self.playersAtPosition.removeAll()

            for case let rest as DataSnapshot in snapshot.children {


                let player = FootballPlayerStruct(snap: rest)
                self.playersAtPosition.append(player ?? FootballPlayerStruct.init())

            }

            self.tableView.reloadData()
            
        }) { (error) in

            print(error.localizedDescription)

        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (playersAtPosition.count + 1)
 
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let depthChartHeader = tableView.dequeueReusableCell(withIdentifier: "depthChartHeaderCell", for: indexPath) as! depthChartHeaderCell
            depthChartHeader.delegate = self
            depthChartHeader.layer.cornerRadius = 10
            depthChartHeader.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            return depthChartHeader
        
        }
        else {
            
            let player = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! playerCell
            
            let playerStruct = playersAtPosition[indexPath.row - 1]
            player.playerNameLabel.text = playerStruct.name
            player.playerDescriptionLabel.text = ("\(playerStruct.height ?? "No height") \(playerStruct.weight ?? 0)")
            
            return player
            
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = scoreScoutColors.white
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 75
    
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        if indexPath.row != 0 {
            return true
        }
        else {
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return UITableViewCell.EditingStyle.none
        
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
       
        return false
    
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        
        if destinationIndexPath.row == 0 {
            
            print("nope")
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                            toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if proposedDestinationIndexPath.row == 0 {
            
            return sourceIndexPath
            
        }
        
        return proposedDestinationIndexPath
        
    }
    
    func navTabSetup() {
        
        let NavTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
        viewIfLoaded?.backgroundColor = scoreScoutColors.lightGray
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationItem.title = "Depth Chart"
        navigationController?.navigationBar.titleTextAttributes = NavTextAttributes
        self.tableView.separatorColor = UIColor.darkGray
        
    }
    
    
}

protocol updateTableInCell: class {
    
    func updateTableView(position: String)
    
}

fileprivate class depthChartHeaderCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    weak var buttonTimer: Timer?
    
    weak var delegate: updateTableInCell?
    func updateTable() {
        
        delegate?.updateTableView(position: depthChartLabel.text ?? "QB")
        
    }
    
    let positions = ["QB", "RB", "FB", "WR", "TE", "C", "LG", "RG", "LT", "RT", "FS", "SS", "CB", "LOLB", "ROLB", "MLB", "LE", "RE", "DT", "K", "P", "LS", "KR", "PR"]
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        createPickers()
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let depthChartLabel: UnderlineTextField = {
        
        let field = UnderlineTextField()
        field.text = "QB"
        field.textFieldForBlackBackground(underlineField: field)
        field.clearButtonMode = UITextFieldViewMode.never
        field.textAlignment = .center
        field.font = UIFont(name: "Verdana-Bold", size: 20)
        return field
        
    }()
    
    func createPickers() {
        
        let positionPicker = UIPickerView()
        positionPicker.delegate = self
        positionPicker.backgroundColor = scoreScoutColors.white
        depthChartLabel.inputView = positionPicker
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = scoreScoutColors.lightGray
        toolBar.tintColor = UIColor.black
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(removeKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        depthChartLabel.inputAccessoryView = toolBar
        
    }
    
    @objc func removeKeyboard(sender: UIBarButtonItem!) {
        
        if buttonTimer == nil {
            
            depthChartLabel.endEditing(true)
            buttonTimer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(doNothing), userInfo: nil, repeats: false)
            updateTable()
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
            
            depthChartLabel.text = positions[row]
        
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
        label.text = positions[row]

        return label
    
    }
    
    @objc func doNothing() {
        return
    }
    
    func setUpViews() {
        
        addSubview(depthChartLabel)
        
        depthChartLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        depthChartLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        depthChartLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
    
    }
    
}

fileprivate class playerCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let playerNameLabel: UILabel = {
       
        let label = UILabel()
        label.text = String()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Verdana-Bold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    let playerDescriptionLabel: UILabel = {
        
        let label = UILabel()
        label.text = String()
        label.textColor = UIColor.lightGray
        label.font = UIFont(name: "Verdana-Bold", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    func setUpViews() {
        
        addSubview(playerNameLabel)
        addSubview(playerDescriptionLabel)
        
        
        playerNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        playerNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -5).isActive = true
        
        playerDescriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        playerDescriptionLabel.centerYAnchor.constraint(equalTo: playerNameLabel.centerYAnchor, constant: 20).isActive = true
        
    }
    
    
}


