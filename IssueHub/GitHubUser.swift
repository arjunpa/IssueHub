//
//  GitHubUser.swift
//  IssueHub
//
//  Created by Arjun P A on 31/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit
import ObjectMapper

struct GitHubUser: Mappable {
    
    var login:String!
    var id:Int!
    var avatarURL:String!
    init?(_ map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        login     <- map["login"]
        id        <- map["id"]
        avatarURL <- map["avatar_url"]
    }
}
