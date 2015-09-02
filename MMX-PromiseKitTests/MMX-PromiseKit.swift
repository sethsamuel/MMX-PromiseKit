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

private struct stubs{
    static let channels = ["channel"]
    static let tags = Set(["tag", ""])
}

class MMX_PromiseKit : XCTestCase{

    func testFindByTags(){

        class MockMMXChannel : MMXChannel {
            override class func findByTags(tags: Set<NSObject>!, success: ((Int32, [AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) -> Void{
                success(2, stubs.channels)
            }
            
        }

        let ex = expectationWithDescription("findByTags")

        MockMMXChannel.findByTags(["foo"])
            .then{ count, channels -> Void in
                XCTAssertEqual(count, 2, "Count equal")
                XCTAssertEqual(channels, stubs.channels, "Channels equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testChannelsStartingWithName() {
        class MockMMXChannel : MMXChannel {
            override class func channelsStartingWith(name: String!, limit : Int32, success: ((Int32, [AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) -> Void{
                success(2, stubs.channels)
            }
            
        }
        
        let ex = expectationWithDescription("channelsStartingWithName")
        
        MockMMXChannel.channelsStartingWithName("foo", limit: 100)
            .then{ count, channels -> Void in
                XCTAssertEqual(count, 2, "Count equal")
                XCTAssertEqual(channels, stubs.channels, "Channels equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testTags(){
        class MockMMXChannel : MMXChannel {
            override func tagsWithSuccess(success: ((Set<NSObject>!) -> Void)!, failure: ((NSError!) -> Void)!) {
                success(stubs.tags)
            }
            
        }
        
        let ex = expectationWithDescription("tags")
        
        MockMMXChannel().tags()
            .then{ tags -> Void in
                XCTAssertEqual(tags, stubs.tags, "Tags equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testSetTags(){
        class MockMMXChannel : MMXChannel {
            override func setTags(tags: Set<NSObject>!, success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success();
            }
        }
        
        let ex = expectationWithDescription("setTags")
        
        MockMMXChannel().setTags(Set(["newtag"]))
            .then{ 
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
}

