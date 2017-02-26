//
//  User.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/20/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    var name: String?
    var screenName: String?
    var profileURL: NSURL?
    var tagline: String?
    
    var dictionary: NSDictionary?
    
    //deserialization of dictionary
    init(dictionary: NSDictionary){
        
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString{
            profileURL = NSURL(string: profileURLString as String)
        }
        
        
        tagline = dictionary["description"] as? String
    }
    
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get {
            
            if _currentUser == nil
            {
            
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
            
                if let userData = userData
                {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: .allowFragments) as? NSDictionary
                
                    _currentUser = User(dictionary: dictionary!)
                }
            }
            return _currentUser
        }
        //saves user
        set(user){
            
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            }else{
                defaults.removeObject(forKey: "currentUserData")
            }
            
            defaults.synchronize() //saves/updates it
        }
    }
    
    
}
