//
//  MMX-PromiseKit.swift
//  MMX-PromiseKit
//
//  Created by Seth on 9/1/15.
//  Copyright (c) 2015 Seth Samuel. All rights reserved.
//

import Foundation
import MMX
import MMX_PromiseKit
import OCMock
import XCTest

class MMX_PromiseKit : XCTestCase{
    
    func testFindByTags(){
        class MockMMXChannel : MMXChannel {
            override class func findByTags(tags: Set<NSObject>!, success: ((Int32, [AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) -> Void{
                let stubChannels = ["stub"]
                success(2, stubChannels)
            }

        }

        let ex = expectationWithDescription("findByTags")

        MockMMXChannel.findByTags(["foo"])
            .then{ count, channels -> Void in
                XCTAssertEqual(count, 2, "Count equal")
                let stubChannels = ["stub"]
                XCTAssertEqual(channels, stubChannels, "Channels equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testChannelsStartingWithName() {
        class MockMMXChannel : MMXChannel {
            override class func channelsStartingWith(name: String!, limit : Int32, success: ((Int32, [AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) -> Void{
                let stubChannels = ["stub"]
                success(2, stubChannels)
            }
            
        }
        
        let ex = expectationWithDescription("channelsStartingWithName")
        
        MockMMXChannel.channelsStartingWithName("foo", limit: 100)
            .then{ count, channels -> Void in
                XCTAssertEqual(count, 2, "Count equal")
                let stubChannels = ["stub"]
                XCTAssertEqual(channels, stubChannels, "Channels equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
}

