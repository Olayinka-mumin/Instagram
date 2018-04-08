//
//  ChooseStoryVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/7/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit
import MobileCoreServices

class ChooseStoryVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imagePickerController = UIImagePickerController();
    var selectedVideo: NSURL?;
    var currentTime = NSDate();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imagePickerController.delegate = self;
        imagePickerController.sourceType = .photoLibrary;
        imagePickerController.mediaTypes = ["public.movie"];
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let currentUser = Instagram.Instance.getCurrentUser();
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        guard let theVideo = info[UIImagePickerControllerReferenceURL] as! NSURL else {
//            fatalError("Expected a dictionary containing a url, but was provided the following: \(info)")
//        }
        
        let theVideo = info[UIImagePickerControllerMediaURL] as! NSURL;

        selectedVideo = theVideo;
        let story = Stories(createdBy: currentUser, timeAgo: currentTime, Video: selectedVideo!);
        
        Instagram.Instance.postStory(story: story);
        dismiss(animated: true, completion: nil);
        tabBarController?.selectedIndex = 0;
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
    
    @IBAction func pickVideo(_ sender: UIButton) {
        present(imagePickerController, animated: true, completion: nil);
    }
    
}
