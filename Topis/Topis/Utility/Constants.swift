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
        static let detailsVC = "DetailsVC"
        static let exploreVC = "ExploreVC"
    }

    static let fakeJSON: String = {
        let path = Bundle.main.path(forResource: "fakeJson", ofType: "txt")
        var jsonString = ""
        do {
            try jsonString = String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
            
        }
        return jsonString
    }()
    
    static let fakeUserJSON: String = {
        let path = Bundle.main.path(forResource: "fakeUser", ofType: "txt")
        var jsonString = ""
        do {
            try jsonString = String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
            
        }
        return jsonString
    }()

    static let themeColor = 0xFF9532
    static let grayTextColor = 0xB8B8B8
    static let blackTextColor = 0x000000
    static let maximumTopicLength = 255
    
    static let warningTitle = "Warning!"
    static let messageExceedContentLength = "Your content exceeds the maximum length (\(Constants.maximumTopicLength) characters)!"
    
    static let messageEnterNothing = "You didn't enter the content of your topic!"
}
