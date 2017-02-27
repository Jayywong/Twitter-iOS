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
    
    //tweet + fav count
    @IBOutlet weak var retweetCt: UILabel!
    @IBOutlet weak var favCt: UILabel!
    
    //retweet + fav btn
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var favBtn: UIButton!
    
    
    
    var tweet: Tweet!
    {
        didSet
        {
            //label + image set
            tweetLabel.text = tweet.text
            //print("1231231231231231231whywontyouwork!!!!!\(tweet.text)")
            nameLabel.text = (tweet.user?.name)!
            tweetTime.text = tweet.timeStamp
            userNameLabel.text = tweet.user?.screenName
            profileImageView.setImageWith((tweet.user?.profileURL)! as URL)
            
            
            // tweet counts
            if tweet.retweetCount != 0 && tweet.retweetCount < 1000
            {
                //retweetCt.isHidden = false
                retweetCt.text = String(tweet.retweetCount)
            }else
            {
                retweetCt.text = "\(Double(tweet.retweetCount/1000))k"
            }
            
            //favorite count!!!
            if tweet.favoriteCount != 0 && tweet.favoriteCount < 1000
            {
                favCt.text = String(tweet.favoriteCount)
            }else
            {
                favCt.text = "\(Double(tweet.favoriteCount/1000))k"
            }
            
            
        }
    }
    
    var retweeted = false
    var favorited = false
    
    @IBAction func retweetClicked(_ sender: AnyObject) {
        if retweeted == false
        {
            retweetBtn.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.retweet(id: tweet.id!, success: { (tweet) in
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            
            retweetCt.text = "\((tweet.retweetCount)+1)"
            retweeted = true

        } else
        {
            retweetBtn.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
            retweetCt.text = "\((tweet.retweetCount))"
            retweeted = false

        }
        
    }
    
    @IBAction func favClicked(_ sender: AnyObject) {
        if favorited == false
        {
            favBtn.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance?.favorited(id: tweet.id!, success: {
        
                }, failure: { (error: Error) in
                    print(error.localizedDescription)
            })
            
            favCt.text = "\((tweet.favoriteCount)+1)"
            favorited = true
            
        } else
        {
            favBtn.setImage(UIImage(named: "fav-icon"), for: UIControlState.normal)
            favCt.text = "\((tweet.favoriteCount))"
            favorited = false
            
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
