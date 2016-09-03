//
//  RequestMaker.swift
//  IssueHub
//
//  Created by Arjun P A on 01/09/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import Foundation
import Alamofire

class RequestMaker:NSObject{
    
    enum HTTPMethod:String{
        case GET = "GET"
        case POST = "POST"
    }
    
    static func getHTTPMethod(method:HTTPMethod) -> Alamofire.Method{
        switch method {
        case HTTPMethod.POST:
            return Alamofire.Method.POST
            
        case HTTPMethod.GET:
            return Alamofire.Method.GET
            
        }
    }
    
    static func getEncoding(method:HTTPMethod) -> ParameterEncoding{
        switch method {
        case HTTPMethod.POST:
            return ParameterEncoding.JSON
            
        case HTTPMethod.GET:
            return ParameterEncoding.URL
            
        }
    }
    
    func makeRequest(urlStr:URLStringConvertible,cachePolicy:NSURLRequestCachePolicy?=NSURLRequestCachePolicy.UseProtocolCachePolicy,encoding:ParameterEncoding,method:HTTPMethod, parameters:[String:AnyObject]?, headers:[String:String]?) -> NSURLRequest?{
        
        let httpMethod = RequestMaker.getHTTPMethod(method)
        let request = NSMutableURLRequest.init(URL: NSURL.init(string:urlStr.URLString)!)
        request.cachePolicy = cachePolicy!
        if let headersd = headers{
            
            for (key,value) in headersd{
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        request.HTTPMethod = httpMethod.rawValue
        
        if let parametersd = parameters{
            ParameterEncoding.URL.encode(request, parameters: parametersd)
        }
        
        return request
    }
    
}