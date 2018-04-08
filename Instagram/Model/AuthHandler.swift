//
//  AuthHandler.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/22/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit

class AuthHandler {
    
    var message: String?;
    var title: String?;
    var identity = 0;
    
    func signUp(username: String, password: String) {
        if Instagram.Instance.users.isEmpty != true {
            for user in Instagram.Instance.users {
                if username == user.username {
                    title = "Invalid Authentication";
                    message = "Username already exist";
                } else {
                    title = "Success";
                    message = "You have successfully created an Instagram account";
                    
                    identity += 1;
                    User.instance.id = identity;
                    User.instance.username = username;
                    User.instance.password = password;
                    User.instance.posts = [];
                    User.instance.stories = [];
                    User.instance.profileImage = UIImage(named: "user");
                    User.instance.following = [];
                    User.instance.followers = [];
                    User.instance.notifications = [];
                    
                    Instagram.Instance.updateInstagram();
                }
            }
        } else {
            
            identity += 1;
            User.instance.id = identity;
            User.instance.username = username;
            User.instance.password = password
            User.instance.posts = [];
            User.instance.stories = [];
            User.instance.profileImage = UIImage(named: "user");
            User.instance.following = [];
            User.instance.followers = [];
            User.instance.notifications = [];
            
            title = "Success";
            message = "You have successfully created an Instagram account";
            
            Instagram.Instance.updateInstagram();
        }
    }
    //    End of sign up function

    
    
    func login(username: String, password: String) {
        if(Instagram.Instance.users.isEmpty == true) {
            title = "Invalid Authentication";
            message = "User does not exist, try create a new account";
        } else {
            for user in Instagram.Instance.users {
                if username == user.username && password == user.password {
                    User.instance.id = user.id;
                    User.instance.email = user.email;
                    User.instance.number = user.number;
                    User.instance.username = user.username;
                    User.instance.password = user.password;
                    User.instance.profileImage = user.profileImage;
                    User.instance.posts = user.posts;
                    User.instance.stories = user.stories;
                    User.instance.following = user.following;
                    User.instance.followers = user.followers;
                    User.instance.notifications = user.notifications;
                    
                    title = "Success";
                    message = "Successfully logged in";
                } else {
                    title = "Invalid authentication";
                    message = "Incorrect username or password";
                }
            }
        }
    }
//    End of login function


}
