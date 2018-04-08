//
//  Instagram.swift
//  Instagram
//
//  Created by Olayinka Abdulmumin on 2/21/18.
//  Copyright © 2018 Olayinka Abdulmumin. All rights reserved.
//

import UIKit


extension NSDate: Comparable {}
public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSinceReferenceDate == rhs.timeIntervalSinceReferenceDate;
}
public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.timeIntervalSinceReferenceDate < rhs.timeIntervalSinceReferenceDate;
}

class Instagram {
    private static let _instance = Instagram();
    
    static var Instance: Instagram {
        return _instance;
    }
    
    var users = Array<User>();
    var post = Array<Post>();
    var stories = Array<Stories>();
    
    let currentDate = NSDate();
    var url = NSURL(string: "urlstring");
    
    var userDetail: User?;
    var likeDetail: [Like]?;
    var commentDetail: [Comment]?;
    
    func updateInstagram() {
        let logger = User(id: User.instance.id, email: User.instance.email, number: User.instance.number, username: User.instance.username, password: User.instance.password, profileImage: User.instance.profileImage, posts: User.instance.posts, stories: User.instance.stories, followers: User.instance.followers, following: User.instance.following, notifications: User.instance.notifications);
        
        if Instagram.Instance.users.isEmpty {
            Instagram.Instance.users.append(logger);
        } else {
            
            // Update follow
            for(index, user) in Instagram.Instance.users.enumerated() {
                if user.following?.isEmpty != true {
                    for(index2, following) in user.following!.enumerated() {
                        if logger.id == following.id {
                            Instagram.Instance.users[index].following!.remove(at: index2);
                            Instagram.Instance.users[index].following!.insert(logger, at: index2);
                            for (index3, follower) in User.instance.followers!.enumerated() {
                                if following.id == follower.id {
                                    User.instance.followers?.remove(at: index3);
                                    User.instance.followers?.insert(following, at: index3);
                                }
                            }
                        }
                    }
                }
            }
            
            // Update Instagram
            for (index, user) in Instagram.Instance.users.enumerated() {
                if logger.id == user.id {
                    Instagram.Instance.users.remove(at: index);
                    Instagram.Instance.users.insert(user, at: index);
                } else {
                    Instagram.Instance.users.append(logger);
                }
            }
            
        }
    }
    
    
    //*********** ..Update post function... *********
    func updatePost() -> [Post] {
        post.removeAll();
        
        if (User.instance.posts?.isEmpty)! {
            print("Empty user post");
        } else {
            for post in User.instance.posts! {
                self.post.append(post);
            }
        }
        if (User.instance.following?.isEmpty)! {
            print("Empty following post");
        } else {
            for poster in User.instance.following! {
                if poster.posts?.isEmpty != true {
                    for eachPost in poster.posts! {
                        self.post.append(eachPost);
                    }
                }
            }
        }
        self.post.sort(by:{$0.timeAgo > $1.timeAgo});
        return self.post
    }
    
    
    //*********  ..Update stories function.. *********
    func updateStory() -> [Stories] {
        stories.removeAll();
        
        if (User.instance.stories?.isEmpty)! {
            print("Empty story");
        } else {
            for story in User.instance.stories! {
                self.stories.append(story);
            }
        }
        
        if (User.instance.following?.isEmpty)! {
            print("No following");
        } else {
            for poster in User.instance.following! {
                if poster.stories?.isEmpty != true {
                    for eachStory in poster.stories! {
                        self.stories.append(eachStory);
                    }
                }
            }
        }
        
        self.stories.sort(by: {$0.timeAgo > $1.timeAgo})
        return self.stories;
    }
    
    
    //***** ..Return time function.. *****
    func timeAgoSinceDate(date: NSDate, numericDates: Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
    }
    
    
    func notificationTime(date: NSDate, numericDates: Bool) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = NSDate()
        let earliest = now.earlierDate(date as Date)
        let latest = (earliest == now as Date) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
        
        if (components.year! >= 2) {
            return "\(components.year!)y"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1y"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!)m"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1m"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!)w"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1w"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!)d"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1d"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!)h"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1h"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!)m"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1m"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!)s"
        } else {
            return "Just now"
        }
    }
    
    
    func getCurrentUser() -> User {
        let logger = User(id: User.instance.id, email: User.instance.email, number: User.instance.number, username: User.instance.username, password: User.instance.password, profileImage: User.instance.profileImage, posts: User.instance.posts, stories: User.instance.stories, followers: User.instance.followers, following: User.instance.following, notifications: User.instance.notifications);
        
        return logger;
    }
    
    
    func makePost(post: Post) {
        User.instance.posts?.append(post);
    }
    
    
    func postStory(story: Stories) {
        User.instance.stories?.append(story);
    }
    
}






