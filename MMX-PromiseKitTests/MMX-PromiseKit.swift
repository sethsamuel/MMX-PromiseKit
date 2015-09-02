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
    static let subscribers = ["user1"]
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
    
    func testCreate(){
        class MockMMXChannel : MMXChannel {
            override func createWithSuccess(success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        
        let ex = expectationWithDescription("create")
        
        MockMMXChannel().create()
            .then{
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testDelete(){
        class MockMMXChannel : MMXChannel {
            override func deleteWithSuccess(success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        
        let ex = expectationWithDescription("delete")
        
        MockMMXChannel().delete()
            .then{
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testSubscribe(){
        class MockMMXChannel : MMXChannel {
            override func subscribeWithSuccess(success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        
        let ex = expectationWithDescription("subscribe")
        
        MockMMXChannel().subscribe()
            .then{
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testUnSubscribe(){
        class MockMMXChannel : MMXChannel {
            override func unSubscribeWithSuccess(success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        
        let ex = expectationWithDescription("unSubscribe")
        
        MockMMXChannel().unSubscribe()
            .then{
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
        
    }
    
    func testSubscribedChannels(){
        class MockMMXChannel : MMXChannel {
            override class func subscribedChannelsWithSuccess(success: (([AnyObject]?) -> Void)!, failure: ((NSError!) -> Void)!) {
                success(stubs.channels)
            }
        }
        
        let ex = expectationWithDescription("subscribedChannelsWithSuccess")
        
        MockMMXChannel.subscribedChannels()
            .then{ channels -> Void in
                XCTAssertEqual(channels, stubs.channels, "Channels equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testSubscribers(){
        class MockMMXChannel : MMXChannel {
            override func subscribersWithSuccess(success: ((Int32, [AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) {
                success(2, stubs.subscribers)
            }
        }
        
        let ex = expectationWithDescription("subscribers")
        
        MockMMXChannel().subscribers()
            .then{ count, subscribers -> Void in
                XCTAssertEqual(count, 2, "Count equal")
                XCTAssertEqual(subscribers, stubs.subscribers, "Subscribers equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
}

