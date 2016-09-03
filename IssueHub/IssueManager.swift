//
//  IssueManager.swift
//  IssueHub
//
//  Created by Arjun P A on 30/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit
import ObjectMapper

class IssueManager: NSObject {
    
    var issueURL:NSURL!
    override init() {
        super.init()
        issueURL = NSURL.init(string: APIConstants.issueURL)
    }
    
    func getIssues(success:([Issue]) -> Void, failure:(ErrorType?) -> Void){
        
        let manager = NetworkManager.sharedManager
        
      //  manager.requestWithURL(issueURL, byMethod: RequestMaker.HTTPMethod.GET, forParameters: ["sort":ParameterConstants.SORT_KEY_ISSUES, "direction":ParameterConstants.SORT_ORDER_ISSUES]) { (result, error, resultType) in
        
        
            manager.requestWithURLRequest(issueURL, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, byMethod: RequestMaker.HTTPMethod.GET, forParameters: ["sort":ParameterConstants.SORT_KEY_ISSUES, "direction":ParameterConstants.SORT_ORDER_ISSUES], andHeaders: nil) { (result, error, resultType) in
                
            switch resultType{
            
            case .Success:     var issuesd:[Issue] = []
                               if let areThereIssues:Array<Issue> = Mapper<Issue>().mapArray(result){
                
                                    issuesd = areThereIssues
                                }
                
                            dispatch_async(dispatch_get_main_queue(), {
                                success(issuesd)
                            })
                
            case .Failure: dispatch_async(dispatch_get_main_queue(), {
                             failure(error)
                           })
            }
        }
    }
}
