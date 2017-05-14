//
//  DateTransform.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/11/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import Foundation
import ObjectMapper

open class FullDateTransform: TransformType {
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
        if let timeInt = value as? Double {
            return Date(timeIntervalSince1970: TimeInterval(timeInt))
        }
        
        if var timeStr = value as? String {
            // delete "00 (EST)"
            if timeStr.contains("00 (EST)") {
                timeStr = timeStr.substring(to: timeStr.index(timeStr.endIndex, offsetBy: -8))
            }
            //Create Date Format
            let dateFormatter = DateFormatter()
            
            //Specify Format of String to Parse
            dateFormatter.dateFormat = "EEE MMM dd yyyy HH:mm:ss ZZZZ"
            
            //Parse into NSDate
            let dateFromString = dateFormatter.date(from: timeStr)
            
            //Return Parsed Date
            return dateFromString
        }
        
        return nil
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
        if let date = value {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM dd yyyy HH:mm:ss ZZZZ"
            var timeString = formatter.string(from: date)
            
            if !timeString.contains("00 (EST)") {
                timeString = timeString + "00 (EST)"
            }
            
            return timeString
        }
        return nil
    }
}
