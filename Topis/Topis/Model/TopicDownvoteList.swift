//
//  TopicDownvoteList.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/13/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import ObjectMapper

class TopicDownvoteList: TopicList {
    required convenience init(map: Map) {
        self.init()
    }
    
    override func sort() {
        self.topics.sort { (topic1, topic2) -> Bool in
            if topic1.downvote != topic2.downvote {
                return topic1.downvote > topic2.downvote
            }
            
            return topic1.postedDate > topic2.postedDate
        }
    }
}
