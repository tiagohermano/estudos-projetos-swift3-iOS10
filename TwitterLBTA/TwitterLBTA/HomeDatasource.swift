//
//  HomeDatasource.swift
//  TwitterLBTA
//
//  Created by Dev13 on 15/09/17.
//  Copyright © 2017 Dev13. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
    let users: [User] = {
        let brianUser = User(name: "Brian Voong", username: "@buildthatapp", bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "profile_image"))
        let rayUser = User(name: "Ray Wenderlich", username: "@rwenderlich", bioText: "Ray Wenderlich is an iPhone developer and tweets on topics related to iPhone, software, and gaming. Checkout our conference.", profileImage: #imageLiteral(resourceName: "ray_profile_image"))
        let tiagoUser = User(name: "Tiago Hermano", username: "@late4party", bioText: "Exemplo de bio", profileImage: #imageLiteral(resourceName: "ainsley_hariott"))
        return [brianUser, rayUser, tiagoUser]
    }()
    
//    let words = ["Ronado Nazário", "user2", "user3"]
    let tweets: [Tweet] = {
        let brianUser = User(name: "Brian Voong", username: "@buildthatapp", bioText: "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!", profileImage: #imageLiteral(resourceName: "profile_image"))
        let tweet = Tweet(user: brianUser, message: "Welcome to episode 9 of the Twitter Series, really hope you guys are enjoying the series so far. I really really need a long text block to render out so we're going to stop here.")
        
        let tweet2 = Tweet(user: brianUser, message: "This is the second tweet message for our sample project. Very very exciting message....")
        
        return [tweet, tweet2]
    }()
    
    
    override func footerClasses() -> [DatasourceCell.Type]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [DatasourceCell.Type]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self, TweetCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        if indexPath.section == 1 {
            return tweets[indexPath.item]
        }
        return users[indexPath.item]
    }
    
    override func numberOfSections() -> Int {
        return 2
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        if section == 1 {
            return tweets.count
        }
        
        return users.count
    }
}
