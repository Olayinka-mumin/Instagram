//
//  UserDetailVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/10/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class UserDetailVC: UIViewController {
    
    var user: User?;
    var selectedPost: Post?;

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var changeProfileImgBtn: UIButton!
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var followBtn: UIButton!
    
    @IBOutlet weak var postCount: UIButton!
    @IBOutlet weak var followersCount: UIButton!
    @IBOutlet weak var followingCount: UIButton!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Do any additional setup after loading the view.
        self.storiesCollectionView.dataSource = self;
        self.storiesCollectionView.delegate = self;
        
        self.postCollectionView.dataSource = self;
        self.postCollectionView.delegate = self;
        self.updateUI();
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
        
        followBtn.layer.borderColor = UIColor.init(red: 198/255, green: 197/255, blue: 198/255, alpha: 1).cgColor;
        followBtn.layer.borderWidth = 1.0;
        followBtn.layer.cornerRadius = 7;
        
        profileImage.image = user?.profileImage;
        postCount.setTitle("\(user?.posts?.count ?? 0)", for: .normal);
        followersCount.setTitle("\(user?.followers?.count ?? 0)", for: .normal);
        followingCount.setTitle("\(user?.following?.count ?? 0)", for: .normal);
        
        username.text = user?.username;
    }

}

extension UserDetailVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case storiesCollectionView:
            if let story = user?.stories {
                return story.count
            } else {
                return 0;
            }
        default:
            if let post = user?.posts {
                return post.count;
            } else {
                return 0;
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case storiesCollectionView:
            let cell = storiesCollectionView.dequeueReusableCell(withReuseIdentifier: "profileStoriesCell", for: indexPath) as! ProfileStoriesCell;
            cell.story = user?.stories?[indexPath.item];
            return cell;
        default:
            let cell = postCollectionView.dequeueReusableCell(withReuseIdentifier: "profilePostCell", for: indexPath) as! ProfilePostCell;
            cell.post = user?.posts?[indexPath.item];
            return cell;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == postCollectionView {
            selectedPost = user!.posts![indexPath.item];
            self.performSegue(withIdentifier: "userDetailToPostDetail", sender: nil);
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let postDetailView = segue.destination as? UserDetailPostVC else {
            fatalError("Unexpected sender \(String(describing: sender))");
        }
        postDetailView.post = selectedPost;
    }
    
}














