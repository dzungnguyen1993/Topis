//
//  Topic.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/11/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import ObjectMapper

class Topic: Mappable {
    var id: String = ""
    var title: String = ""
    var content: String = ""
    var postedDate: Date = Date()
    var owner: User = User()
    var comments: [Comment] = [Comment]() // link to Comment
    var upvote: Int = 0
    var downvote: Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        content <- map["content"]
        postedDate <- (map["postedDate"], DateTransform())
        owner <- map["owner"]
        comments <- map["comments"]
        upvote <- map["upvote"]
        downvote <- map["downvote"]
    }
}
