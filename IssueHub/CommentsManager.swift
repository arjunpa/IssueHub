//
//  CommentsManager.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit
import ObjectMapper
class CommentsManager: NSObject {
    
    func getComments(issue:Issue, success:([Comment]) -> Void, failure:(ErrorType?) -> Void){
        
        let manager = NetworkManager.sharedManager
        
     //   manager.requestWithURL(issue.comments_url, byMethod: RequestMaker.HTTPMethod.GET, forParameters: nil) { (result, error, resultType) in
       
        manager.requestWithURLRequest(issue.comments_url, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, byMethod: RequestMaker.HTTPMethod.GET, forParameters: nil, andHeaders: nil) { (result, error, resultType) in
            
            switch resultType{
                
            case .Success:     var comments:[Comment] = []
            if let areThereComments:Array<Comment> = Mapper<Comment>().mapArray(result){
                
                comments = areThereComments
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                success(comments)
            })
                
            case .Failure: dispatch_async(dispatch_get_main_queue(), {
                failure(error)
            })
            }
        }
    }
}
