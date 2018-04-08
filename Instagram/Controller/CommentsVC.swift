//
//  CommentsVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 4/3/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var commentTableView: UITableView!
    
    var comments: [Comment]?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTableView.dataSource = self;
        commentTableView.delegate = self;

        commentTableView.estimatedRowHeight = 80.0;
        commentTableView.rowHeight = UITableViewAutomaticDimension;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let comment = comments {
            return comment.count;
        } else {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commentTableView.dequeueReusableCell(withIdentifier: "allCommentCell", for: indexPath) as! CommentCell;
        cell.comment = self.comments?[indexPath.row];
        return cell;
    }
 
}





