//
//  AddTeamsTableViewController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 7/30/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import UIKit

class AddTeamsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add a Team"
        //navigationController?.navigationBar.barTintColor = UIColor(red: CGFloat(49/255.0), green: CGFloat(79/255.0), blue: CGFloat(79/255.0), alpha: CGFloat(1.0))
        navigationController?.navigationBar.tintColor = UIColor.white
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        
        self.tableView.register(addTeamNameCell.self, forCellReuseIdentifier: "TeamNameCellID")
        self.tableView.register(addTeamStateCell.self, forCellReuseIdentifier: "TeamStateCellID")
        
    
    }
    

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        if indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "TeamNameCellID", for: indexPath)
        }
        else{
            return tableView.dequeueReusableCell(withIdentifier: "TeamStateCellID", for: indexPath)
        }
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.lightGray
        return headerView
    }
    
}
    
class addTeamNameCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Team Name:"
        label.textColor = UIColor.black
        label.font = UIFont(name: "Kefa-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamNameField: UITextField = {
        
        let teamNameField =  UnderlineTextField()
        teamNameField.placeholder = "West Tigers"
        teamNameField.font = UIFont.systemFont(ofSize: 15)
        teamNameField.textColor = UIColor.white
        teamNameField.autocorrectionType = UITextAutocorrectionType.no
        teamNameField.keyboardType = UIKeyboardType.default
        teamNameField.returnKeyType = UIReturnKeyType.done
        teamNameField.clearButtonMode = UITextFieldViewMode.whileEditing;
        teamNameField.translatesAutoresizingMaskIntoConstraints = false
        
        //let border = CALayer()
        //let width = CGFloat(2.0)
        //border.borderColor = UIColor.green.cgColor
        //border.frame = CGRect(x: 0, y: teamNameField.frame.size.height - width, width: teamNameField.frame.size.width, height: teamNameField.frame.size.height)
        //border.borderWidth = width
        //teamNameField.layer.addSublayer(border)
        //teamNameField.layer.masksToBounds = true
        return teamNameField
    }()
    
    func setUpViews() {

        addSubview(teamNameLabel)
        addSubview(teamNameField)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": teamNameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[v0]-22-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": teamNameLabel, "v1": teamNameField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": teamNameField]))
    }
    
}

class addTeamStateCell: UITableViewCell, UITextFieldDelegate {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Team State"
        label.font = UIFont(name: "Kefa-Regular", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamNameField: UITextField = {
        
        let teamNameField =  UnderlineTextField()//(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
        teamNameField.placeholder = "West Tigers"
        teamNameField.font = UIFont.systemFont(ofSize: 15)
        teamNameField.autocorrectionType = UITextAutocorrectionType.no
        teamNameField.keyboardType = UIKeyboardType.default
        teamNameField.returnKeyType = UIReturnKeyType.done
        teamNameField.clearButtonMode = UITextFieldViewMode.whileEditing;
        teamNameField.translatesAutoresizingMaskIntoConstraints = false
        teamNameField.tintColor = UIColor.red
        
        //let border = CALayer()
        //let width = CGFloat(2.0)
        //border.borderColor = UIColor.green.cgColor
        //border.frame = CGRect(x: 0, y: teamNameField.frame.size.height - width, width: teamNameField.frame.size.width, height: teamNameField.frame.size.height)
        //border.borderWidth = width
        //teamNameField.layer.addSublayer(border)
        //teamNameField.layer.masksToBounds = true
        return teamNameField
    }()
    
    func setUpViews() {
        
        addSubview(teamNameLabel)
        addSubview(teamNameField)
        teamNameField.delegate = self
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": teamNameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[v0]-10-[v1]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": teamNameLabel, "v1": teamNameField]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": teamNameField]))
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.tintColor = UIColor.green
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.tintColor = UIColor.green
        return true
    }
    
}

