//
//  Issue.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import Foundation
import ObjectMapper

struct Issue:Mappable {
    
    var issueTitle:String!
    var issueBody:String!
    var created_at:String!
    var updated_at:String!
    var comments_url:String!
    var user:GitHubUser!
    
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        issueTitle   <- map["title"]
        issueBody    <- map["body"]
        created_at   <- map["created_at"]
        updated_at   <- map["updated_at"]
        comments_url <- map["comments_url"]
        user         <- map["user"]
    }
}