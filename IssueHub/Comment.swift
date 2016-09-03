//
//  Comment.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit
import ObjectMapper

struct Comment: Mappable {
    

    var commentBody:String!
    var created_at:String!
    var updated_at:String!
    var user:GitHubUser!
    var isLoadingModel:Bool = false
    var isReloadCell:Bool = false
    init?(_ map: Map) {
        
    }
    
    init(){
    
    }
    
    mutating func mapping(map: Map) {
        
    
        commentBody <- map["body"]
        created_at  <- map["created_at"]
        updated_at  <- map["updated_at"]
        user        <- map["user"]
    }

}
