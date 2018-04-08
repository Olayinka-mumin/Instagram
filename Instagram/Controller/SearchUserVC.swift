//
//  SearchUserVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/8/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class SearchUserVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userTableView: UITableView!
    
    var users: [User]?;
    var selected: User?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self;
        userTableView.dataSource = self;
        
        users = Instagram.Instance.users;
        userTableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let allUsers = users {
            return allUsers.count;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "userSearchCell", for: indexPath) as! SearchUserCell;
        cell.user = self.users?[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = users![indexPath.row];
        self.performSegue(withIdentifier: "searchToDetails", sender: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedUser = segue.destination as? UserDetailVC else {
            fatalError("Unexpected sender: \(String(describing: sender))");
        }
        selectedUser.user = selected;
    }

}



