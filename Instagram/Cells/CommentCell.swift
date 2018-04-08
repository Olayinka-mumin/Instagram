//
//  CommentCell.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 4/3/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commenterImage: UIImageView!
    @IBOutlet weak var commenterName: UILabel!
    @IBOutlet weak var commenterComment: UILabel!
    
    var comment: Comment! {
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
        commenterImage.layer.cornerRadius = commenterImage.bounds.width / 2.0;
        
        commenterImage.image = comment.commenter?.profileImage;
        commenterName.text = comment.commenter?.username;
        commenterComment.text = comment.comment;
    }
}
