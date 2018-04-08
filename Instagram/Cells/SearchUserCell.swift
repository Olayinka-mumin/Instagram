//
//  TableViewCell.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/8/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class SearchUserCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var followBtn: UIButton!
    
    var user: User! {
        didSet {
            updateUI();
        }
    }
    
    var following = false;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2.0;
        profileImage.layer.masksToBounds = true;
        
        profileImage.image = user.profileImage;
        username.text = user.username;
        
        followBtn.layer.cornerRadius = 5;
        
        if (user.followers?.isEmpty)! {
            return;
        } else {
            let currentUser = Instagram.Instance.getCurrentUser();
            for eachUser in user.followers! {
                if eachUser.id == currentUser.id {
                    following = true;
                    followBtn.backgroundColor = UIColor.white;
                    followBtn.setTitle("Unfollow", for: .normal);
                    followBtn.layer.borderColor = UIColor.blue.cgColor;
                    followBtn.layer.borderWidth = 1;
                } else {
                    following = false;
                    followBtn.backgroundColor = UIColor.blue;
                    followBtn.setTitle("Follow", for: .normal);
                    followBtn.layer.borderColor = UIColor.blue.cgColor;
                    followBtn.layer.borderWidth = 1;
                }
            }
        }
    }
    
    @IBAction func follow(_ sender: UIButton) {
        let currentUser = Instagram.Instance.getCurrentUser();
        if following == true {
            for (index, eachUser) in (user.followers?.enumerated())! {
                if eachUser.id == currentUser.id {
                    user.followers?.remove(at: index);
                }
            }
            for (index, eachUser) in (User.instance.following?.enumerated())! {
                if user.id == eachUser.id {
                    User.instance.following?.remove(at: index);
                }
            }
            following = false;
        } else {
            self.user.followers?.append(currentUser);
            User.instance.following?.append(self.user);
            following = true;
        }
    }
        
}
