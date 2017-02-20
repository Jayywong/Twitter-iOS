//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/19/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func LoginButton(_ sender: AnyObject) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "tkYf7uLiSmeWdw4DSyXRpS5Rt", consumerSecret: "aGQZKH6IhKsQb7krdUKOGZFOYef43WCSvWdchzMVefVaaEBuWB")
        
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential?)
            -> Void in
            print("received token")
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")
            UIApplication.shared.openURL(url!)
            
            
        }) { (error: Error?) -> Void in
            print("error: \(error!.localizedDescription)")
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}