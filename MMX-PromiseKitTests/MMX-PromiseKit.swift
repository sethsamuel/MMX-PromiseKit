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
    static let messageContent : [String : AnyObject] = ["Type" : 1, "Message" : "Hello"]
    static let user = MMXUser()
}

class MMX_PromiseKit_MMXChannel : XCTestCase{

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
    
    func testPublishMessageContent(){
        class MockMMXChannel : MMXChannel {
            override func publish(messageContent: [NSObject : AnyObject]!, success: ((MMXMessage!) -> Void)!, failure: ((NSError!) -> Void)!) {
                let message = MMXMessage()
                message.messageContent = messageContent
                success(message)
            }
        }
        
        let ex = expectationWithDescription("publish")

        
        MockMMXChannel().publishMessageContent(stubs.messageContent)
            .then{ message -> Void in
                let messageKeys = message.messageContent.keys.array
                let stubKeys = stubs.messageContent.keys.array
                XCTAssertEqual(messageKeys, stubKeys as [NSObject], "Keys equal");
                XCTAssertEqual(message.messageContent["Type"] as! Int, stubs.messageContent["Type"] as! Int, "Int value equal");                
                XCTAssertEqual(message.messageContent["Message"] as! String, stubs.messageContent["Message"] as! String, "String value equal");
                ex.fulfill()
        }
        waitForExpectationsWithTimeout(2, handler: nil)

    }
    
    func testFetchMessagesBetweenStartDate(){
        class MockMMXChannel : MMXChannel {
            override func fetchMessagesBetweenStartDate(startDate: NSDate!, endDate: NSDate!, limit: Int32, ascending: Bool, success: ((Int32, [AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) {
                let message = MMXMessage()
                message.messageContent = stubs.messageContent
                success(1, [message])
            }
        }
        
        let ex = expectationWithDescription("fetchMessagesBetweenStartDate")
        
        
        MockMMXChannel().fetchMessagesBetweenStartDate(NSDate(), endDate: NSDate(), limit: 1, ascending: true)
            .then{ count, messages -> Void in
                XCTAssertEqual(count, 1, "Count equal")
                if let message = messages.first{
                    let messageKeys = message.messageContent.keys.array
                    let stubKeys = stubs.messageContent.keys.array
                    XCTAssertEqual(messageKeys, stubKeys as [NSObject], "Keys equal");
                    XCTAssertEqual(message.messageContent["Type"] as! Int, stubs.messageContent["Type"] as! Int, "Int value equal");
                    XCTAssertEqual(message.messageContent["Message"] as! String, stubs.messageContent["Message"] as! String, "String value equal");
                }else{
                    XCTAssert(false, "Message returned")
                }
                ex.fulfill()
        }
        waitForExpectationsWithTimeout(2, handler: nil)
        
    }
    
    func testInviteUser(){
        class MockMMXChannel : MMXChannel {
            override func inviteUser(user: MMXUser!, comments: String!, success: ((MMXInvite!) -> Void)!, failure: ((NSError!) -> Void)!) -> String! {
                success(MMXInvite())
                return "1"
            }
        }
        
        let ex = expectationWithDescription("inviteUser")
        
        let (messageId, promise) = MockMMXChannel().inviteUser(MMXUser(), comments: "foo")
            promise
            .then{ invite -> Void in
                XCTAssertNotNil(invite, "Invite not nil")
                ex.fulfill()
        }
        XCTAssertEqual(messageId, "1", "Message id returned")
        waitForExpectationsWithTimeout(2, handler: nil)
    }
}

class MMX_PromiseKit_MMXInvite : XCTestCase{

    func testAcceptWithComments(){
        class MockMMXInvite : MMXInvite{
            override func acceptWithComments(comments: String!, success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        let ex = expectationWithDescription("acceptWithComments")
        
        MockMMXInvite().acceptWithComments("foo")
            .then{ invite -> Void in
                ex.fulfill()
        }
        waitForExpectationsWithTimeout(2, handler: nil)
        
    }

    func testDeclineWithComments(){
        class MockMMXInvite : MMXInvite{
            override func declineWithComments(comments: String!, success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        let ex = expectationWithDescription("declineWithComments")
        
        MockMMXInvite().declineWithComments("foo")
            .then{ invite -> Void in
                ex.fulfill()
        }
        waitForExpectationsWithTimeout(2, handler: nil)
        
    }
}

class MMX_PromiseKit_MMXMessage : XCTestCase{

    func testSend(){
        class MockMMXMessage : MMXMessage{
            override func sendWithSuccess(success: (() -> Void)!, failure: ((NSError!) -> Void)!) -> String! {
                success()
                return "1"
            }
        }
        
        let ex = expectationWithDescription("send")
        
        let (messageId, promise) = MockMMXMessage().send()
        promise
            .then{
                ex.fulfill()
        }
        XCTAssertEqual(messageId, "1", "Message id returned")
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testReplyWithContent(){
        class MockMMXMessage : MMXMessage{
            override func replyWithContent(content : [NSObject:AnyObject], success: (() -> Void)!, failure: ((NSError!) -> Void)!) -> String! {
                success()
                return "1"
            }
        }
        
        let ex = expectationWithDescription("replyWithContent")
        
        let (messageId, promise) = MockMMXMessage().replyWithContent(["foo":"bar"])
        promise
            .then{
                ex.fulfill()
        }
        XCTAssertEqual(messageId, "1", "Message id returned")
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testReplyAllWithContent(){
        class MockMMXMessage : MMXMessage{
            override func replyAllWithContent(content : [NSObject:AnyObject], success: (() -> Void)!, failure: ((NSError!) -> Void)!) -> String! {
                success()
                return "1"
            }
        }
        
        let ex = expectationWithDescription("replyAllWithContent")
        
        let (messageId, promise) = MockMMXMessage().replyAllWithContent(["foo":"bar"])
        promise
            .then{
                ex.fulfill()
        }
        XCTAssertEqual(messageId, "1", "Message id returned")
        waitForExpectationsWithTimeout(2, handler: nil)
    }
}

class MMX_PromiseKit_MMXUser : XCTestCase{
    func testRegisterWithCredential(){
        class MockMMXUser : MMXUser{
            override func registerWithCredential(credential: NSURLCredential!, success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        
        let ex = expectationWithDescription("registerWithCredential")
        
        MockMMXUser().registerWithCredential(NSURLCredential())
            .then{
                ex.fulfill()
        }

        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testLogInWithCredential(){
        class MockMMXUser : MMXUser{
            override class func logInWithCredential(credential: NSURLCredential!, success: ((MMXUser) -> Void)!, failure: ((NSError!) -> Void)!) {
                success(stubs.user)
            }
        }
        
        let ex = expectationWithDescription("logInWithCredential")
        
        MockMMXUser.logInWithCredential(NSURLCredential())
            .then{ user -> Void in
                XCTAssertEqual(user, stubs.user, "User returned")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testLogout(){
        class MockMMXUser : MMXUser{
            override class func logOutWithSuccess(success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        
        let ex = expectationWithDescription("logOut")
        
        MockMMXUser.logOut()
            .then{
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testChangePasswordWithCredential(){
        class MockMMXUser : MMXUser{
            override func changePasswordWithCredential(credential: NSURLCredential!, success: (() -> Void)!, failure: ((NSError!) -> Void)!) {
                success()
            }
        }
        
        let ex = expectationWithDescription("changePasswordWithCredential")
        
        MockMMXUser().changePasswordWithCredential(NSURLCredential())
            .then{
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
    }
    
    func testFindByDisplayName(){
        class MockMMXUser : MMXUser {
            override class func findByDisplayName(displayName : String, limit : Int32, success: ((Int32, [AnyObject]!) -> Void)!, failure: ((NSError!) -> Void)!) {
                success(2, [stubs.user])
            }
        }
        
        let ex = expectationWithDescription("findByDisplayName")
        
        MockMMXUser.findByDisplayName("name", limit: 10)
            .then{ count, users -> Void in
                XCTAssertEqual(count, 2, "Count equal")
                XCTAssertEqual(users, [stubs.user], "Users equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
        
    }
    
    func testUserForUsername(){
        class MockMMXUser : MMXUser {
            override class func userForUsername(username : String, success: ((MMXUser!) -> Void)!, failure: ((NSError!) -> Void)!) {
                success(stubs.user)
            }
        }
        
        let ex = expectationWithDescription("userForUsername")
        
        MockMMXUser.userForUsername("name")
            .then{ user -> Void in
                XCTAssertEqual(user, stubs.user, "User equal")
                ex.fulfill()
        }
        
        waitForExpectationsWithTimeout(2, handler: nil)
        
    }
}