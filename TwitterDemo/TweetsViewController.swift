//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/24/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        print("calling hometimeline")
        TwitterClient.sharedInstance.homeTimeline(success:
        { (tweets: [Tweet]) in
            self.tweets = tweets
            for tweet in tweets
            {
                print(tweet.text!)
            }
            self.tableView.reloadData()
            print("boom works")
            }, failure: { (error: Error) in
                print("fail to get hometimeline")
                print(error.localizedDescription)
        })
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogoutButton(_ sender: AnyObject) {
        
        TwitterClient.sharedInstance.logout()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }

    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "tweetDetail"
        {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let data = tweets[(indexPath?.row)!]
            
            let DetailedTweetController = segue.destination as! DetailedTweetViewController
            DetailedTweetController.tweet = data
        }
        
        if segue.identifier == "ProfileView"
        {
            
            
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            //view -> navigationcontroller -> view
            let navigationcontroller = segue.destination as! UINavigationController
            let viewController = navigationcontroller.topViewController as! ProfileViewController
            viewController.tweet = tweet
            viewController.user = tweet.user
        }
        
      /*  if segue.identifier == "ComposeView"
        {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let navigationController = segue.destination as! UINavigationController
            let composeViewController = navigationController.topViewController as! ComposeViewController
            
            composeViewController.user = tweet.user
        }*/
        
    }
    

}
