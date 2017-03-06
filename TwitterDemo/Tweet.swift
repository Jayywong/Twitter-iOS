//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/20/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var user: User?
    var text: String?
    var timeStamp: String?
    var timeStampString : Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var id: Int?
    
    init(dictionary: NSDictionary)
    {
        user = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        id = (dictionary["id"] as? Int) ?? 0
        timeStamp = dictionary["created_at"] as? String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timeStampString = formatter.date(from: timeStamp!)
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        timeStamp = formatter.string(from: timeStampString!)
        
    }
    
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in dictionaries{
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    
}
