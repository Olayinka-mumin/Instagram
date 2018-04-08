//
//  ConfirmPostVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/6/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class ConfirmPostVC: UIViewController, UITextFieldDelegate {
    
    var createdBy = Instagram.Instance.getCurrentUser();
    var time = NSDate();
    var caption: String?;
    var image: UIImage?;
    var video: NSURL?;
    
    
    @IBOutlet weak var postCaptionText: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let imagePost = image {
            postImage.image = imagePost
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        postCaptionText.resignFirstResponder();
        return true;
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func post(_ sender: UIButton) {
        let post = Post(createdBy: createdBy, timeAgo: time, caption: postCaptionText.text, Image: image!, Video: video, likes: [], comments: []);
        Instagram.Instance.makePost(post: post);
//        self.performSegue(withIdentifier: "postToFeed", sender: nil);
        tabBarController?.selectedIndex = 0;
    }
    
}
