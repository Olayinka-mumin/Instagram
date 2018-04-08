//
//  ProfilePostCell.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/28/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class ProfilePostCell: UICollectionViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    
    var post: Post! {
        didSet {
            self.updateUI();
        }
    }
    
    func updateUI() {
        postImage.image = post.Image;
    }
}
