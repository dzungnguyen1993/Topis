//
//  Extensions.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

extension UIColor {
    
    // initialize UIColor from hex
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}

extension String {
    // get height of label based on its content
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
    
    func heightWithLineBreak(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let strings = self.components(separatedBy: "\n")
        
        var totalHeight: CGFloat = 0
        for string in strings {
            let lineHeight = string.height(withConstrainedWidth: width, font: font)
            totalHeight += lineHeight
        }
        
        return totalHeight
    }
}

extension Date {
    func toDateTimeString() -> String
    {
        let formatter = DateFormatter()
        //Specify Format of String to Parse
//        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let timeString = formatter.string(from: self)
        
        return timeString
    }
}
