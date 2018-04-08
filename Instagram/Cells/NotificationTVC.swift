//
//  NotificationTVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/28/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var notifyTime: UILabel!
    
    var notification: Notifications! {
        didSet {
            self.updateUI();
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateUI() {
        
        userImage.image = notification.user.profileImage;
        userName.setTitle(notification.user.username, for: .normal);
        actionLabel.text = notification.action;
        actionImage.image = notification.post?.Image;
        notifyTime.text = Instagram.Instance.notificationTime(date: notification.timeAgo, numericDates: true);
        
        userImage.layer.cornerRadius = userImage.bounds.width / 2.0;
        userImage.layer.masksToBounds  = true;
    }

}






