//
//  NetworkManager.swift
//  IssueHub
//
//  Created by Arjun P A on 30/08/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
     enum NetworkResult:Int{
      case Success = 1
      case Failure = 0
    }
    
    
    static var sharedManager:NetworkManager = NetworkManager.init()
    
    
    func requestWithURL(url:URLStringConvertible, byMethod method:RequestMaker.HTTPMethod,forParameters parameters:[String:AnyObject]?=nil, andHeaders headers:[String:String]?=nil, WithCallBack:(result:String?, error:ErrorType?, resultType:NetworkResult) -> Void){
       
       
       request(RequestMaker.getHTTPMethod(method), url, parameters: parameters, encoding: RequestMaker.getEncoding(method), headers: headers)
       .responseString { (response) in
        
            switch response.result{
                
                case .Success(let value):
                        WithCallBack(result: value,error: nil,resultType: .Success)
                        
                        break
                case .Failure(let error):
                        WithCallBack(result: nil,error: error,resultType: .Failure)
                        break
            }
        }
    }
    
    func requestWithURLRequest(url:URLStringConvertible,cachePolicy:NSURLRequestCachePolicy? = NSURLRequestCachePolicy.UseProtocolCachePolicy,byMethod method:RequestMaker.HTTPMethod,forParameters parameters:[String:AnyObject]?=nil, andHeaders headers:[String:String]?=nil,WithCallBack:(result:String?, error:ErrorType?, resultType:NetworkResult) -> Void){
        
        

       let request = RequestMaker.init().makeRequest(url,cachePolicy: cachePolicy,encoding: RequestMaker.getEncoding(method),method: method, parameters: parameters, headers: headers)
        
        Manager.sharedInstance.request(request!)
            .responseString { (response) in
                
                switch response.result{
                    
                case .Success(let value):
                    WithCallBack(result: value,error: nil,resultType: .Success)
                    
                    break
                case .Failure(let error):
                    WithCallBack(result: nil,error: error,resultType: .Failure)
                    break
                }
        }

 
    }
    
 
}
