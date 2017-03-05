//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/20/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    static var sharedInstance: TwitterClient {
        struct Static {
            static let instance  = TwitterClient(
                baseURL: URL(string: "https://api.twitter.com")!,
                consumerKey: "tkYf7uLiSmeWdw4DSyXRpS5Rt",
                consumerSecret: "aGQZKH6IhKsQb7krdUKOGZFOYef43WCSvWdchzMVefVaaEBuWB")
        }
        
        return Static.instance!
    }
    
    //static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "tkYf7uLiSmeWdw4DSyXRpS5Rt", consumerSecret: "aGQZKH6IhKsQb7krdUKOGZFOYef43WCSvWdchzMVefVaaEBuWB")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        
        loginSuccess = success
        loginFailure = failure
        
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?)
            -> Void in
            print("i got a token. token is \(requestToken!)")
            if let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)"){
                print("url is this")
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                
            }else{
                print("failed to make url")
            }
            
        }) { (error: Error?) -> Void in
            print("TwitterClient: fail to log in")
            self.loginFailure?(error!)
        }

    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
            //print("I received access token!")
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) -> () in
                self.loginFailure?(error)
                print("fail to fetch token")
            })
            
            
            
            
        }) { (error: Error?) -> Void in
            //print("error: \(error!.localizedDescription)")
            print("fail to open url")
            self.loginFailure?(error!)
        }
    }
    
    
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        print("calling home in twitterClient again")
        print(TwitterClient.sharedInstance)
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            
            let dictionaries = response as! [NSDictionary]
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            for tweet in tweets {
                print("\(tweet.text!)")
            }
            success(tweets)
            
            }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
                print("failed to call home_time api")
                
                failure(error)
        })
        
    }
    
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ())
    {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask!, response: Any?) -> Void in
            //print("acount: \(response)")
            
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
            print("fail to get current user")
        })
    }
    
    
    func retweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ())
    {
        
        post("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) in
            
            //let tweet = Tweet.tweetsWithArray(dictionaries: response as! [NSDictionary])
            success()
            
            
        }) {(task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        }
    }
    
    func favorited(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> ())
    {
        
        post("1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: {(task: URLSessionDataTask, response: Any?) in
            
            success()
            
        }) {(task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        }
    }

    
}
