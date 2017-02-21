//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Jason Wong on 2/20/17.
//  Copyright © 2017 Jason Wong. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var text: NSString?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    
    init(dictionary: NSDictionary)
    {
        text = dictionary["text"] as? NSString
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favourites_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString
        {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timeStamp = formatter.date(from: timestampString) as NSDate?
        }
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
