//
//  TopisTests.swift
//  TopisTests
//
//  Created by Thanh-Dung Nguyen on 5/9/17.
//  Copyright © 2017 Dzung Nguyen. All rights reserved.
//

import XCTest
@testable import Topis

class TopisTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // test parse user from JSON
    func testParseUser() {
        let currentUser = DataManager.shared.getCurrentUser()
        XCTAssertEqual(currentUser.id, "291f9487-3d35-451e-b583-06d1c890aaa6", "Parse user failed")
    }
    
    // test parse topics from JSON
    func testParseJSON() {
        let topicList = DataManager.shared.getTopicList()
        XCTAssertEqual(topicList?.count, 25, "Parse topics failed")
    }
    
    // test calculate height of label based on its content
    func testCalculateLabelHeight() {
        let string = "hello \ntoday"
        let height = string.heightWithLineBreak(withConstrainedWidth: 100, font: Constants.contentFont)
        XCTAssertEqual(height, 30, "Calculate height incorrect")
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
