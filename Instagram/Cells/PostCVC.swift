//
//  PostCVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/23/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PostCVC: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterName: UIButton!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postLikes: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postTextField: UITextField!
    @IBOutlet weak var postTimeAgo: UILabel!
    @IBOutlet weak var postCaption: UILabel!
    @IBOutlet weak var postComments: UIButton!
    @IBOutlet weak var videoPlayerBtn: UIButton!
    @IBOutlet weak var likeBtnOutlet: UIButton!
    
    var liked = false;
    
    var post: Post! {
        didSet {
            updateUI();
        }
    }
    
    var playerController = AVPlayerViewController();
    var player: AVPlayer?;
    
    var parentViewController: UIViewController?;
    
    func updateUI() {
        posterImage.image = post.createdBy.profileImage;
        posterName.setTitle(post.createdBy.username, for: []);
        postImage.image = post.Image;
        postLikes.setTitle("\(post.likes.count) Likes", for: .normal);
        userImage.image = User.instance.profileImage;
        postCaption.text = post.caption
        postTimeAgo.text = Instagram.Instance.timeAgoSinceDate(date: post.timeAgo, numericDates: false);
        postComments.setTitle("\(post.comments.count) comments", for: .normal);
        
        postImage.layer.masksToBounds = true;
        
        userImage.layer.cornerRadius = userImage.bounds.width / 2.0;
        userImage.layer.masksToBounds = true;
        
        posterImage.layer.cornerRadius = posterImage.bounds.width / 2.0;
        posterImage.layer.masksToBounds = true;

        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 10, height: 20));
        
        postTextField.leftView = paddingView;
        postTextField.leftViewMode = .always;
        postTextField.layer.borderColor = UIColor.init(red: 190/225, green: 190/225, blue: 190/225, alpha: 1).cgColor;
        postTextField.layer.borderWidth = 1.0;
        postTextField.layer.cornerRadius = 15;
        postTextField.delegate = self;
        
        if post.Video?.absoluteString == "urlstring" {
            videoPlayerBtn.isHidden = true;
        }
        
        if (post?.likes.isEmpty)! {
            return;
        } else {
            for eachLike in (post?.likes)! {
                if eachLike.likeables?.id == User.instance.id {
                    self.likeBtnOutlet.setImage(UIImage(named: "Hearts-96"), for: .normal);
                    liked = true;
                } else {
                    self.likeBtnOutlet.setImage(UIImage(named: "icon-like"), for: .normal);
                    liked = false;
                }
            }
        }
    }
    
    @IBAction func likeBtn(_ sender: UIButton) {
        switch liked {
        case false:
            self.likeBtnOutlet.setImage(UIImage(named: "Hearts-96"), for: .normal);
            let user = Instagram.Instance.getCurrentUser();
            let liker = Like(likeables: user);
//            self.post.likes.append(liker);

            for (index, eachUser) in Instagram.Instance.users.enumerated() {
                if eachUser.id == post.createdBy.id {
                    print("postIndex");
                    for (postIndex, eachPost) in eachUser.posts!.enumerated() {
                        if eachPost ==  self.post {
                            Instagram.Instance.users[index].posts![postIndex].likes.append(liker);
                        } else {
                            print("It desent match");
                        }
                    }
                }
            }
            
            self.liked = true;
        default:
            self.likeBtnOutlet.setImage(UIImage(named: "icon-like"), for: .normal);
            var likerIndex: Int = 0;
            
            for (index, eachLike) in post.likes.enumerated() {
                if eachLike.likeables?.id == User.instance.id {
                    post.likes.remove(at: index);
                    likerIndex = index;
                }
            }
            
            for (index, user) in Instagram.Instance.users.enumerated() {
                if user.id == post.createdBy.id {
                    for (postIndex, eachPost) in (user.posts?.enumerated())! {
                        if eachPost == self.post {
                            Instagram.Instance.users[index].posts![postIndex].likes.remove(at: likerIndex);
                        }
                    }
                }
            }
            self.liked = false;
        }
        
    }
    
    @IBAction func playVideo(_ sender: UIButton) {
        self.player = AVPlayer(url: post.Video! as URL);
        self.playerController.player = self.player;
        parentViewController?.present(self.playerController, animated: true, completion: {
            self.playerController.player?.play();
        })
    }
    
    @IBAction func clickUser(_ sender: UIButton) {
        Instagram.Instance.userDetail = post.createdBy;
        parentViewController?.performSegue(withIdentifier: "newsToUserDetail", sender: nil);
    }
    
    @IBAction func clickLikes(_ sender: UIButton) {
        Instagram.Instance.likeDetail = post.likes;
        parentViewController?.performSegue(withIdentifier: "newsToLikes", sender: nil);
    }
    
    @IBAction func clickComments(_ sender: UIButton) {
        Instagram.Instance.commentDetail = post.comments;
        parentViewController?.performSegue(withIdentifier: "newsToComments", sender: nil);
    }
    
    
}

extension PostCVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == postTextField {
            textField.resignFirstResponder();
            if textField.text != "" {
                let user = Instagram.Instance.getCurrentUser();
                let comment = Comment(commenter: user, comment: textField.text);
                //post.comments.append(comment);
                
                for (index, eachUser) in Instagram.Instance.users.enumerated() {
                    if eachUser.id == post.createdBy.id {
                        for (postIndex, eachPost) in eachUser.posts!.enumerated() {
                            if eachPost ==  self.post {
                                Instagram.Instance.users[index].posts![postIndex].comments.append(comment);
                            }
                        }
                    }
                }
                
            }
        }
        postTextField.text = "";
        return true;
    }
}





struct TestPost {
    var postUserImage: UIImage?
    var name: String?
    var image: UIImage?
    var likes: String?
    var userImage: UIImage?
    var timeAgo: String?
    var caption: String?
    
    static func fetchPost() -> [TestPost] {
        var posts = [TestPost]()
        
        let post1 = TestPost(postUserImage: UIImage(named: "profile1"), name: "abdul", image: UIImage(named: "f1"), likes: "10 likes", userImage: UIImage(named: "profile1"), timeAgo: "8 hours ago", caption: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.");
        
        let post2 = TestPost(postUserImage: UIImage(named: "profile1"), name: "lennon", image: UIImage(named: "f4"), likes: "12 likes", userImage: UIImage(named: "profile1"), timeAgo: "10 hours ago", caption: "");
        
        let post3 = TestPost(postUserImage: UIImage(named: "profile1"), name: "therealksi", image: UIImage(named: "f5"), likes: "105 likes", userImage: UIImage(named: "profile1"), timeAgo: "8 hours ago", caption: "");
        
        posts.append(post1);
        posts.append(post2);
        posts.append(post3);
        
        return posts;
    }
}


