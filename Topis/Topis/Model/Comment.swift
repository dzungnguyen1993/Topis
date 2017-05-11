//
//  Comment.swift
//  Topis
//
//  Created by Thanh-Dung Nguyen on 5/11/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import ObjectMapper

class Comment: Mappable {
    var id: String = ""
    var content: String = ""
    var owner: User = User() // link to User
    var postedDate: Date = Date()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        content <- map["content"]
        owner <- map["owner"]
        postedDate <- (map["postedDate"], DateTransform())
    }
}
