//
//  Constants.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import Foundation

struct Constants {
    struct Identifiers {
        static let topicCell = "TopicCell"
    }
    
    struct ViewControllers {
        static let homeVC = "HomeVC"
        static let newTopicVC = "NewTopicVC"
    }
    
    static let themeColor = 0xFF9532
    static let grayTextColor = 0xB8B8B8
    static let blackTextColor = 0x000000
    
    static let fakeJSON: String = {
        let path = Bundle.main.path(forResource: "fakeJson", ofType: "txt")
        var jsonString = ""
        do {
            try jsonString = String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
        
        }
        return jsonString
    }()
}
