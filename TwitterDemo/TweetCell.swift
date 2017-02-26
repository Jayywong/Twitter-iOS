//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/25/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTime: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    @IBOutlet weak var replyLabel: UIImageView!
    @IBOutlet weak var retweetLabel: UIImageView!
    @IBOutlet weak var favoriteLabel: UIImageView!
    
    
    
    var tweet: Tweet! {
        didSet{
            tweetLabel.text = tweet.text
            //print("1231231231231231231whywontyouwork!!!!!\(tweet.text)")
            nameLabel.text = (tweet.user?.name)!
            tweetTime.text = tweet.timeStamp
            userNameLabel.text = tweet.user?.screenName
            profileImageView.setImageWith((tweet.user?.profileURL)! as URL)
            
            
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
