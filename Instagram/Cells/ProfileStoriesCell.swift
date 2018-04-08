//
//  ProfileStoriesCell.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/28/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class ProfileStoriesCell: UICollectionViewCell {
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var storyUsername: UILabel!
    @IBOutlet weak var storyUserImage: UIImageView!
    
    var story: Stories! {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        imageBgView.layer.cornerRadius = imageBgView.bounds.width / 2.0;
        imageBgView.layer.borderWidth = 2.0;
        imageBgView.layer.borderColor = UIColor.init(red: 198/255, green: 197/255, blue: 198/255, alpha: 1).cgColor;
        imageBgView.layer.masksToBounds = true;
        
        storyUserImage.layer.cornerRadius = storyUserImage.bounds.width / 2.0;
        storyUserImage.layer.masksToBounds = true;
        
        
        storyUserImage.image = story.createdBy.profileImage;
        storyUsername.text = story.createdBy.username;
    }

}
