//
//  TopicList.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/11/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import ObjectMapper

class TopicList: Mappable {
    var listTopics: [Topic] = [Topic]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        listTopics <- map["topics"]
    }
}
