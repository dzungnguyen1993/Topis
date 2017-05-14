//
//  TopicList.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/11/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import ObjectMapper

class TopicList: Mappable {
    internal var topics: [Topic] = [Topic]()
    
    required convenience init(map: Map) {
        self.init()
    }
    
    required init() {
        
    }
    
    func mapping(map: Map) {
        topics <- map["topics"]
    }
    
    init(topics: [Topic]) {
        self.topics = topics
        self.sort()
    }
    
    func sort() {
        
    }
    
    func add(topic: Topic) {
        self.topics.append(topic)
    }
    
    lazy var count: Int = {
        return self.topics.count
    }()
    
    func filter(text: String) -> [Topic] {
        let result = topics.filter { (topic) -> Bool in
            return topic.title.lowercased().contains(text.lowercased())
        }
        
        return result
    }
}

extension TopicList {
    subscript (i: Int) -> Topic {
        return self.topics[i]
    }
}
