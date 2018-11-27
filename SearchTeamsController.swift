//
//  SearchTeamsController.swift
//  Score and Scout
//
//  Created by Jeremy Morgan on 8/5/18.
//  Copyright © 2018 Score and Scout. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class SearchTeamsController: UITableViewController, UISearchBarDelegate {
    
    var ref = Database.database().reference()
    
    var teamsArray = [String]()
    var filteredTeamsArray = [String]()
    
    let searchController = UISearchController()
    
    let searchBar: UISearchBar = {
        
        let bar = UISearchBar()
        bar.searchBarStyle = UISearchBarStyle.minimal
        bar.placeholder = "Search for teams to follow"
        bar.showsCancelButton = true
        bar.sizeToFit()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
        return bar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTabSetup()
        searchBar.delegate = self
        
        self.tableView.register(teamCell.self, forCellReuseIdentifier: "teamCell")
        self.tableView.register(headerCell.self, forCellReuseIdentifier: "headerCell")
        
        ref.child("Search Teams").queryOrdered(byChild: "Search Teams").observe(.childAdded, with: { (snapshot) in
        
            let key = snapshot.key 
            print(key)
            
            self.teamsArray.append(key)
            
        }) { (error) in
            print(error.localizedDescription)
        }
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            
        self.searchBar.becomeFirstResponder()
        
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        print("canceled")
        navigationController?.popViewController(animated: false)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
        
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print("let's search")
        searchBar.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filterContent(searchText: searchText)
        
    }
    
    func filterContent(searchText:String)
    {
        print(searchText)
        self.filteredTeamsArray = self.teamsArray.filter {
            
            $0.contains(searchText)
            
        }
        
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (searchBar.text?.count)! > 2 && (filteredTeamsArray.count != 0) {
            return (filteredTeamsArray.count + 1) // plus 1 because of header
        }
        else {
            
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var description = String()
        
        if (indexPath.row) == 0 {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! headerCell
            
            headerCell.categoryLabel.text = "Teams"
            headerCell.layer.cornerRadius = 10
            headerCell.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            return headerCell
            
        }
        else {
            
            let teamCell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath) as! teamCell
            
            //team = filteredTeamsArray[indexPath.row - 1] // -1 because our first index uses a header cell

            teamCell.teamNameLabel.text = filteredTeamsArray[indexPath.row - 1]
            ref.child("Search Teams/\(filteredTeamsArray[indexPath.row - 1])/Description").observeSingleEvent(of: .value, with: { (snapshot) in
                let value = snapshot.value as? String
                description = value ?? ""
                teamCell.teamNameDescription.text = description
            })
            {(error) in
                print(error.localizedDescription)
            }
            
            if (filteredTeamsArray.count == 1) {
                
                print("only one cell")
                teamCell.layer.cornerRadius = 10
                teamCell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                teamCell.layer.masksToBounds = true
                
            }
            else {
                
                if (indexPath.row == (filteredTeamsArray.count)) { // would be (filteredTeamsArray.count -1) without header
                    
                    teamCell.layer.cornerRadius = 10
                    teamCell.layer.masksToBounds = true
                    teamCell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                }
                else {
                    
                    teamCell.layer.cornerRadius = 0
                    
                }
            }
            
            return teamCell
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    

    func navTabSetup() {
        
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.contentInset = UIEdgeInsets(top: 20,left: 0,bottom: 0,right: 0)
        viewIfLoaded?.backgroundColor = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1)
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationItem.setHidesBackButton(true, animated: true)
        tabBarController?.tabBar.isHidden = true
        self.tableView.separatorColor = UIColor.darkGray
        
    }
    
}


fileprivate class teamCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.default
        self.accessoryType = .disclosureIndicator
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let teamNameLabel: UILabel = {
        let label = UILabel()
        label.text = String()
        label.font = UIFont(name: "Kefa-Regular", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let teamNameDescription: UILabel = {
        
        let label = UILabel()
        label.text = "Team Description"
        label.font = UIFont(name: "Kefa-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        
        addSubview(teamNameLabel)
        addSubview(teamNameDescription)
        
        teamNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -50).isActive = true
        teamNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        teamNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        teamNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        teamNameDescription.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -50).isActive = true
        teamNameDescription.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: +10).isActive = true
        teamNameDescription.widthAnchor.constraint(equalToConstant: 200).isActive = true
        teamNameDescription.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }

}

fileprivate class headerCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCellSelectionStyle.none
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = String()
        label.font = UIFont(name: "Verdana-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setUpViews() {
        
        
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
        addSubview(categoryLabel)
        
        categoryLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -70).isActive = true
        categoryLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        categoryLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        categoryLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
}

