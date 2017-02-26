//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/25/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTime: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet{
            tweetLabel.text = tweet.text
            //print("1231231231231231231\(tweet.text)")
            nameLabel.text = tweet.user?.name
            
            
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
