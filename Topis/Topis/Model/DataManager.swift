//
//  DataManager.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/11/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    static let shared = DataManager()
    
    private override init() {
        
    }
    
    func getTopicList() -> TopicList? {
        let jsonString = Constants.fakeJSON
        
        let topicList = TopicList(JSONString: jsonString)
        
        return topicList
    }
    
    func getCurrentUser() -> User {
        let jsonString = Constants.fakeUserJSON
        
        let user = User(JSONString: jsonString)
        
        guard user != nil else {
            return User()
        }
        
        return user!
    }
}
