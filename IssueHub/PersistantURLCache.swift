//
//  PersistantURLCache.swift
//  IssueHub
//
//  Created by Arjun P A on 02/09/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import Foundation

/*
    Forcing NSURLCache to ignore cache-control header and force cache response till an expiry time
 */
class PersistantURLCache: NSURLCache {
    let CACHE_EXPIRY_KEY = "CacheDateInSec";
    
    ///Cche expiry time
    let CACHE_EXPIRY_INTERVALINSEC:NSTimeInterval = 60*60*24*1;
    
    // override to check cache expiry time via userinfo against custom cache expiry time
    override func cachedResponseForRequest(request:NSURLRequest) -> NSCachedURLResponse? {
        
        var response:NSCachedURLResponse? = nil
        
        //get cached response
        if let cachedResponse = super.cachedResponseForRequest(request) {
            
            //get userInfo
            if let userInfo = cachedResponse.userInfo {
                
                // get cache date
                if let cacheDate = userInfo[CACHE_EXPIRY_KEY] as? NSDate {
                    
                    // is cache expired?
                    if (cacheDate.timeIntervalSinceNow < -CACHE_EXPIRY_INTERVALINSEC) {
                        // remove old cache data
                        self.removeCachedResponseForRequest(request);
                    } else {
                        // return cached response
                        response = cachedResponse
                    }
                }
            }
        }
        
        return response;
    }
    
    // store cached response
    override func storeCachedResponse(cachedResponse: NSCachedURLResponse, forRequest: NSURLRequest) {
        // create userInfo dictionary for string cache date
        var userInfo = NSMutableDictionary()
        if let cachedUserInfo = cachedResponse.userInfo {
            userInfo = NSMutableDictionary(dictionary:cachedUserInfo)
        }
        // add current date to the UserInfo
        userInfo[CACHE_EXPIRY_KEY] = NSDate()
        
        // create new cached response
        let newCachedResponse = NSCachedURLResponse(response:cachedResponse.response, data:cachedResponse.data, userInfo:userInfo as [NSObject : AnyObject],storagePolicy:cachedResponse.storagePolicy)
        super.storeCachedResponse(newCachedResponse, forRequest:forRequest)
        
    }
}