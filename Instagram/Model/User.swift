//
//  User.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/21/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

struct User {
    
    private static let _instance = User();
    
    static func param() -> User {
        return _instance;
    }
    static var instance = User.param()
    
    var id: Int?;
    var email: String?;
    var number: Int?;
    var username: String?;
    var password: String?;
    var profileImage: UIImage?;
    var posts: [Post]? = [Post]();
    var stories: [Stories]? = [Stories]();
    var followers: [User]? = [User]();
    var following: [User]? = [User]();
    var notifications: [Notifications]? = [Notifications]();
}

struct Post {
    var createdBy: User;
    var timeAgo: NSDate;
    var caption: String?;
    var Image: UIImage;
    var Video: NSURL?;
    var likes: [Like] = [Like]();
    var comments: [Comment] = [Comment]();
}
func ==(lhs: Post, rhs: Post) -> Bool {
    return lhs.timeAgo == rhs.timeAgo;
}


struct Stories {
    var createdBy: User;
    var timeAgo: NSDate;
    var Video: NSURL;
}

struct Like {
    var likeables: User?;
}

struct Comment {
    var commenter: User?;
    var comment: String?;
}
struct Notifications {
    var user: User;
    var post: Post?;
    var action: String;
    var timeAgo: NSDate;
}


