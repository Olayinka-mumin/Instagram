//
//  StoriesCVC.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/22/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class StoriesCVC: UICollectionViewCell {
    
    @IBOutlet weak var imageBgView: UIView!
    @IBOutlet weak var storyUsername: UILabel!
    @IBOutlet weak var storyUserImage: UIImageView!
    
    var story: Stories! {
        didSet {
            updateUI()
        }
    }
    

    
    func updateUI() {
        
        imageBgView.layer.cornerRadius = imageBgView.bounds.width / 2.0;
        imageBgView.layer.borderWidth = 2.0;
        imageBgView.layer.borderColor = UIColor.init(red: 126/255, green: 0/255, blue: 95/255, alpha: 1).cgColor;
        imageBgView.layer.masksToBounds = true;
        
        storyUserImage.layer.cornerRadius = storyUserImage.bounds.width / 2.0;
        storyUserImage.layer.masksToBounds = true;
        
        
        storyUserImage.image = story.createdBy.profileImage;
        storyUsername.text = story.createdBy.username;
    }
}


struct Tours {
    var image: UIImage?
    var name: String?
    
    static func fetchData() -> [Tours] {
        var tours = [Tours]()
        
        let tour1 = Tours(image: UIImage(named: "user"), name: "greece");
        let tour2 = Tours(image: UIImage(named: "user"), name: "USA");
        let tour3 = Tours(image: UIImage(named: "profile1"), name: "UK");
        let tour4 = Tours(image: UIImage(named: "user"), name: "dubai");
        let tour5 = Tours(image: UIImage(named: "user"), name: "france");
        let tour6 = Tours(image: UIImage(named: "profile1"), name: "qatar");
        
        tours.append(tour1);
        tours.append(tour2);
        tours.append(tour3);
        tours.append(tour4);
        tours.append(tour5);
        tours.append(tour6);
        
        return tours;
    }
}

