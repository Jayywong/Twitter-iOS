//
//  DetailedTweetViewController.swift
//  TwitterDemo
//
//  Created by Jason Wong on 3/4/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class DetailedTweetViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var tweet: Tweet!
    var retweeted = false
    var favorited = false


    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = tweet.user?.name
        profileImageView.setImageWith((tweet.user?.profileURL)! as URL)
        userNameLabel.text = tweet.user?.screenName
        tweetLabel.text = tweet.text
        timeLabel.text = tweet.timeStamp
        
        // tweet counts
        // tweet counts
        if tweet.retweetCount != 0 && tweet.retweetCount < 1000
        {
            //retweetCt.isHidden = false
            retweetCountLabel.text = String(tweet.retweetCount)
        }else if tweet.retweetCount > 1000
        {
            retweetCountLabel
                .text = "\(Double(tweet.retweetCount/1000))k"
        }
        
        //favorite count!!!
        if tweet.favoriteCount != 0 && tweet.favoriteCount < 1000
        {
            favoriteCountLabel.text = String(tweet.favoriteCount)
        }else if tweet.favoriteCount > 1000
        {
            favoriteCountLabel.text = "\(Double(tweet.favoriteCount/1000))k"
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func retweetOnClick(_ sender: Any) {
        if retweeted == false
        {
            retweetBtn.setImage(UIImage(named: "retweet-icon-green"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance.retweet(id: tweet.id!, success: { (tweet) in
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            retweeted = true
            
        } else
        {
            retweetBtn.setImage(UIImage(named: "retweet-icon"), for: UIControlState.normal)
            retweeted = false
            
        }
        
    }
    
    
    @IBAction func favoriteOnClick(_ sender: Any) {
        if favorited == false
        {
            favoriteBtn.setImage(UIImage(named: "favor-icon-red"), for: UIControlState.normal)
            
            TwitterClient.sharedInstance.favorited(id: tweet.id!, success: {
                
            }, failure: { (error: Error) in
                print(error.localizedDescription)
            })
            favorited = true
            
        } else
        {
            favoriteBtn.setImage(UIImage(named: "fav-icon"), for: UIControlState.normal)
            favorited = false
            
        }
    }
    
    //no need
    @IBAction func replyOnClick(_ sender: Any) {
    }
    
    

  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ReplyView"
        {
            let button = sender as! UIButton
            let view = button.superview!
            
            let navigationController = segue.destination as! UINavigationController
            let composeTweetViewController = navigationController.topViewController as! ComposeViewController
            
        }
    }
    */

}
