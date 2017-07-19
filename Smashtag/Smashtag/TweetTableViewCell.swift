//
//  TweetTableViewCell.swift
//  Smashtag
//
//  Created by iDev on 17/07/17.
//  Copyright © 2017 iDev. All rights reserved.
//

import UIKit
import Twitter

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetProfileImageView: UIImageView!
    @IBOutlet weak var tweetCreatedLabel: UILabel!
    @IBOutlet weak var tweetUserLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Twitter.Tweet? { didSet { updateUI() } }
    
    private func updateUI() {
        tweetTextLabel?.text = tweet?.text
        tweetUserLabel?.text = tweet?.user.name
        
        if let profileImageURL = tweet?.user.profileImageURL {
            DispatchQueue.global(qos: .userInteractive).async {
                if let imageData = try? Data(contentsOf: profileImageURL) {
                    self.tweetProfileImageView?.image = UIImage(data: imageData)
                }
            }
        }
        
    }
}
