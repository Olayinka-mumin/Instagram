//
//  NotificationVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/28/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var notificationTableView: UITableView!
    
    var notifications = User.instance.notifications;
    var currentTime = NSDate();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
//        let note = Notifications(user: Instagram.Instance.defaultUser, post: Instagram.Instance.post[0], action: "liked your post", timeAgo: currentTime);
//        notifications?.append(note);
        
        notificationTableView.dataSource = self;
        notificationTableView.delegate = self;
        notifications?.sort(by: {$0.timeAgo > $1.timeAgo});
        notificationTableView.reloadData();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let notify = self.notifications {
            return notify.count;
        } else {
            return 2;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTVC;
        cell.notification = self.notifications?[indexPath.row];
        return cell;
    }
    
}
