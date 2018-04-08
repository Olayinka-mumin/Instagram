//
//  PostTypeVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 3/4/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class PostTypeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func chooseStory(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newStorySegue", sender: nil);
    }
    
    @IBAction func choosePost(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newPostSegue", sender: nil);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
