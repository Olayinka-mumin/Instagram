//
//  LikeCell.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 4/3/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class LikeCell: UITableViewCell {

    @IBOutlet weak var likerImage: UIImageView!
    @IBOutlet weak var likerName: UILabel!
    
    var like: Like! {
        didSet {
            updateUI();
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI() {
        
        likerImage.layer.cornerRadius = likerImage.bounds.width / 2.0;
        likerImage.layer.masksToBounds = true;
        
        likerName.text = like.likeables?.username;
        likerImage.image = like.likeables?.profileImage;
    }
    
}
