//
//  LikesVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 4/3/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class LikesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var likesTableView: UITableView!
    
    var likes: [Like]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likesTableView.dataSource = self;
        likesTableView.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let allLikes = likes {
            return allLikes.count;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likesTableView.dequeueReusableCell(withIdentifier: "allLikesCell", for: indexPath) as! LikeCell;
        cell.like = self.likes?[indexPath.row];
        return cell;
    }
    
}




