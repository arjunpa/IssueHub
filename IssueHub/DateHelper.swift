//
//  DateHelper.swift
//  IssueHub
//
//  Created by Arjun P A on 02/09/16.
//  Copyright © 2016 Arjun P A. All rights reserved.
//

import UIKit

class DateHelper: NSObject {
    
    enum DateHelperFormat:Int {
        case TZ = 1
    }
    static func makeDateStringWithFormat(format: DateHelperFormat, dateStr:String) -> String{
        
        let formatter:NSDateFormatter = NSDateFormatter.init()
        
        switch format {
        case DateHelperFormat.TZ: formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
                                  break
        
        }
        let date = formatter.dateFromString(dateStr)
        
        formatter.dateFormat = "DD MMMM, YYYY HH:mm:ss"
        
        return formatter.stringFromDate(date!)
    }
}
