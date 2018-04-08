//
//  NewsFeedVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/22/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import AVKit

class NewsFeedVC: UIViewController {

    var stories: [Stories]?
    var posts: [Post]?
    var userDetail: User?;
    
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var postTableView: UITableView!
    
    var playerController = AVPlayerViewController();
    var player: AVPlayer?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storiesCollectionView.dataSource = self;
        storiesCollectionView.delegate = self;
        self.stories = Instagram.Instance.updateStory();
        storiesCollectionView.reloadData();
        
        postTableView.dataSource = self;
        postTableView.delegate = self;
        self.posts = Instagram.Instance.updatePost();
        postTableView.reloadData();
        
        postTableView.estimatedRowHeight = 574.0;
        postTableView.rowHeight = UITableViewAutomaticDimension;
        
        self.navigationItem.hidesBackButton = true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.stories = Instagram.Instance.updateStory();
        storiesCollectionView.reloadData();
        
        self.posts = Instagram.Instance.updatePost();
        postTableView.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case is UserDetailVC:
            guard let selectedUser = segue.destination as? UserDetailVC else {
                fatalError("Unexpected sender \(String(describing: sender))");
            }
            selectedUser.user = Instagram.Instance.userDetail;
        case is LikesVC:
            guard let selectedLikes = segue.destination as? LikesVC else {
                fatalError("Unexpected sender \(String(describing: sender) )");
            }
            selectedLikes.likes = Instagram.Instance.likeDetail;
        case is CommentsVC:
            guard let selectedComments = segue.destination as? CommentsVC else {
                fatalError("Unexpected sender \(String(describing: sender))");
            }
            selectedComments.comments = Instagram.Instance.commentDetail;
        default:
            print("another segue");
        }
    }
}


extension NewsFeedVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let story = self.stories {
            return story.count;
        } else {
            return 0;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storiesCollectionView.dequeueReusableCell(withReuseIdentifier: "storiesCell", for: indexPath) as! StoriesCVC;
        cell.story = self.stories?[indexPath.item];
        return cell;        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = stories![indexPath.item];
        print(selected.Video);
        
        self.player = AVPlayer(url: selected.Video as URL);
        self.playerController.player = self.player;
        self.present(self.playerController, animated: true) {
            self.playerController.player?.play();
        }
    }
    
}

extension NewsFeedVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let testPosts = self.posts {
            return testPosts.count
        } else {
            return 0;
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postTableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCVC;
        cell.post = self.posts?[indexPath.item];
        cell.parentViewController = self;
        return cell;
    }
}







