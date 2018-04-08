//
//  ProfileVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/28/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit
import AVKit

class ProfileVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeProfileImgBtn: UIButton!
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet weak var postCount: UIButton!
    @IBOutlet weak var followersCount: UIButton!
    @IBOutlet weak var followingCount: UIButton!
    @IBOutlet weak var userTitle: UILabel!
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    var stories: [Stories]?;
    var posts: [Post]?;
    
    var selectedPost: Post?;
    
    var playerController = AVPlayerViewController();
    var player: AVPlayer?;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        stories = User.instance.stories;
        updateUI();
        storiesCollectionView.dataSource = self;
        storiesCollectionView.delegate = self;
        
//        postCollectionView.register(UINib(nibName: "name", bundle: nil), forCellWithReuseIdentifier: "profilePostCell");
        
        postCollectionView.dataSource = self;
        postCollectionView.delegate = self;
        posts = User.instance.posts;
        
        navigationItem.title = User.instance.username;
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func updateUI() {
        self.profileImage.layer.cornerRadius = self.profileImage.bounds.width / 2.0;
        self.profileImage.layer.masksToBounds = true;
        self.profileImage.layer.borderWidth = 1.0;
        
        self.imageBgView.layer.cornerRadius = self.imageBgView.bounds.width / 2.0;
        self.imageBgView.layer.masksToBounds = true;
        self.imageBgView.layer.borderColor = UIColor.init(red: 198/255, green: 197/255, blue: 198/255, alpha: 1).cgColor;
        self.imageBgView.layer.borderWidth = 1.0;
        view.bringSubview(toFront: changeProfileImgBtn);
        
        self.changeProfileImgBtn.layer.cornerRadius = 15;
        self.profileImage.clipsToBounds = true;
        
        for button in self.buttons {
            button.layer.borderColor = UIColor.init(red: 198/255, green: 197/255, blue: 198/255, alpha: 1).cgColor;
            button.layer.borderWidth = 1.0;
            button.layer.cornerRadius = 7;
        }
        
        postCount.setTitle("\(User.instance.posts?.count ?? 0)", for: .normal);
        followersCount.setTitle("\(User.instance.followers?.count ?? 0)", for: .normal);
        followingCount.setTitle("\(User.instance.following?.count ?? 0)", for: .normal);
        userTitle.text = User.instance.username;
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let postDetailView = segue.destination as? UserDetailPostVC else {
            fatalError("Unexpected sender \(String(describing: sender))");
        }
        postDetailView.post = selectedPost;
    }
}

extension ProfileVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case storiesCollectionView:
            if let story = stories {
                return story.count
            } else {
                return 0;
            }
        default:
            if let post = posts {
                return post.count
            } else {
                return 0;
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case storiesCollectionView:
            let cell = storiesCollectionView.dequeueReusableCell(withReuseIdentifier: "profileStoriesCell", for: indexPath) as! ProfileStoriesCell;
            cell.story = self.stories?[indexPath.item];
            return cell;
        default:
            let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "profilePostCell", for: indexPath) as! ProfilePostCell;
            cell.post = self.posts?[indexPath.item];
            return cell;
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case postCollectionView:
            selectedPost = posts![indexPath.item];
            self.performSegue(withIdentifier: "profilePostToDetail", sender: nil);
        default:
            let selected = stories![indexPath.item];
            
            self.player = AVPlayer(url: selected.Video as URL!);
            self.playerController.player = self.player;
            self.present(self.playerController, animated: true, completion: {
                self.playerController.player?.play();
            })
        }
    }
    
    
}
















