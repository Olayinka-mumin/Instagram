//
//  UserDetailPostVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/11/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class UserDetailPostVC: UIViewController, UITextFieldDelegate {
    
    var post: Post! {
        didSet {
            updateUI();
        }
    };
    var liked = false;
    
    @IBOutlet weak var posterProfileImg: UIImageView!
    @IBOutlet weak var posterUsername: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var videoPlay: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var postTimeAgo: UILabel!
    @IBOutlet weak var likesCountBtn: UIButton!
    @IBOutlet weak var commentCountBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUI() {
//        posterProfileImg.image = post.createdBy.profileImage;
        posterUsername.text = post?.createdBy.username;
        postImage.image = post?.Image;
       
        //Check if user has liked before or not
        if (post.likes.isEmpty) {
            return;
        } else {
            for eachLike in (post?.likes)! {
                if eachLike.likeables?.id == User.instance.id {
                    self.likeBtn.setImage(UIImage(named: "Hearts-96"), for: .normal);
                    liked = true;
                } else {
                    self.likeBtn.setImage(UIImage(named: "icon-like"), for: .normal);
                    liked = false;
                }
            }
        }
        
        // Check if it is a video or image
        if post.Video?.absoluteString == "urlstring" {
            videoPlay.isHidden = true;
        }
        
        //style text field
        commentTextField.layer.borderColor = UIColor.init(red: 190/225, green: 190/225, blue: 190/225, alpha: 1).cgColor;
        commentTextField.layer.borderWidth = 1.0;
        commentTextField.layer.cornerRadius = 15;
        commentTextField.delegate = self;
        
        // Likes and comment count
        likesCountBtn.setTitle("\(post.likes.count) likes", for: .normal);
        commentCountBtn.setTitle("\(post.comments.count) comments", for: .normal);
    }
    
    
    @IBAction func likeButton(_ sender: UIButton) {
        switch liked {
        case false:
            self.likeBtn.setImage(UIImage(named: "Hearts-96"), for: .normal);
            let user = Instagram.Instance.getCurrentUser();
            let liker = Like(likeables: user);
            self.post?.likes.append(liker);
        default:
            self.likeBtn.setImage(UIImage(named: "icon-like"), for: .normal);
            for (index, eachLike) in post.likes.enumerated() {
                if eachLike.likeables?.id == User.instance.id {
                    post.likes.remove(at: index);
                }
            }
            self.liked = false;
        }
    }
    
    var playerController = AVPlayerViewController();
    var player: AVPlayer?;
    
    @IBAction func playVideo(_ sender: UIButton) {
        self.player = AVPlayer(url: post.Video! as URL);
        self.playerController.player = self.player;
        self.present(playerController, animated: true) {
            self.playerController.player?.play();
        }
    }
    
    // post a comment
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == commentTextField {
            textField.resignFirstResponder();
            if textField.text != "" {
                let user = Instagram.Instance.getCurrentUser();
                let comment = Comment(commenter: user, comment: textField.text);
                post.comments.append(comment);
            }
            textField.text = "";
        }
        return true;
    }
    
}







