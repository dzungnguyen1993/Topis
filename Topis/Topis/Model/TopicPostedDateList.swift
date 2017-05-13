//
//  TopicPostedDateList.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/13/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import ObjectMapper

class TopicPostedDateList: TopicList {
    required convenience init(map: Map) {
        self.init()
    }
    
    override func sort() {
        self.topics.sort { (topic1, topic2) -> Bool in
            return topic1.postedDate > topic2.postedDate
        }
    }
}
