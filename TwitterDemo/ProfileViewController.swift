//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Jason Wong on 3/4/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var ProfileImageView: UIImageView! //background
    @IBOutlet weak var numberOfTweets: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var actualProfileImage: UIImageView!
    
    
    
    var user: User!
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProfileImageView.setImageWith(tweet.user?.profileURL as! URL)
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = tweet.user?.screenName
        actualProfileImage.setImageWith(tweet.user?.profileURL as! URL)
        numberOfTweets.text = "\(user.tweetct)\n Tweets"
        followerLabel.text = "\(user.followersct)\n Followers"
        followingLabel.text = "\(user.followingct)\n Following"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func HomeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ComposeView"
        {
            let navigationController = segue.destination as! UINavigationController
            let composeTweetViewController = navigationController.topViewController as! ComposeViewController
            composeTweetViewController.tweet = tweet
            
        }
        
    }
    

}
