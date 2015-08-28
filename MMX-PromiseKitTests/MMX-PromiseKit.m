//
//  MMX-PromistKit.m
//  MMX-PromiseKit
//
//  Created by Seth on 8/26/15.
//  Copyright (c) 2015 Seth Samuel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <PromiseKit/PromiseKit.h>
#import "MMX+PromiseKit.h"
#import <OCMock/OCMock.h>

@interface MMX_PromiseKit : XCTestCase

@end

@implementation MMX_PromiseKit

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//MMXChannel

//+(PMKPromise*)channelsStartingWith:(NSString *)name limit:(int)limit;
- (void)testChannelsStartingWith {
    
    NSArray *stubChannels = @[@{},@{}];
    
    id mock = OCMClassMock([MMXChannel class]);
    [OCMStub([mock channelsStartingWith:[OCMArg any] limit:100 success:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)(int count, NSArray *channels) = nil;
        [invocation getArgument:&successBlock atIndex:4];
        successBlock(2, stubChannels);
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"channelsStartingWith"];
    [MMXChannel channelsStartingWith:@"" limit:100]
    .then(^(NSNumber *count, NSArray* channels){
        XCTAssertEqual(count.integerValue, 2);
        XCTAssertNotNil(channels);
        XCTAssertEqualObjects(channels, stubChannels);

        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
      //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

//+(PMKPromise*)findByTags:(NSSet*)tags;
- (void)testFindByTags {
    NSArray *stubChannels = @[@{},@{}];
    
    id mock = OCMClassMock([MMXChannel class]);
    [OCMStub([mock findByTags:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)(int count, NSArray *channels) = nil;
        [invocation getArgument:&successBlock atIndex:3];
        successBlock(2, stubChannels);
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"findByTags"];
    [MMXChannel findByTags:[NSSet setWithArray:@[@"foo"]]]
    .then(^(NSNumber *count, NSArray* channels){
        XCTAssertEqual(count.integerValue, 2);
        XCTAssertNotNil(channels);
        XCTAssertEqualObjects(channels, stubChannels);
        
        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
        //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

//-(PMKPromise*)tags;
- (void)testTags {
    NSSet *stubTags = [NSSet setWithArray:@[@"foo"]];
    
    id mock = OCMPartialMock([MMXChannel new]);
    [OCMStub([mock tagsWithSuccess:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)(NSSet *tags) = nil;
        [invocation getArgument:&successBlock atIndex:2];
        successBlock(stubTags);
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"tags"];
    [mock tags]
    .then(^(NSSet *tags){
        XCTAssertNotNil(tags);
        XCTAssertEqualObjects(tags, stubTags);
        
        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
        //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

//-(PMKPromise*)setTags:(NSSet*)tags;
- (void)testSetTags {
    NSSet *stubTags = [NSSet setWithArray:@[@"foo"]];
    
    id mock = OCMPartialMock([MMXChannel new]);
    [OCMStub([mock setTags:[OCMArg any] success:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)() = nil;
        [invocation getArgument:&successBlock atIndex:3];
        successBlock();
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"tags"];
    [mock setTags:stubTags]
    .then(^(){
        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
        //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

//-(PMKPromise*)create;
- (void)testCreate {
    
    id mock = OCMPartialMock([MMXChannel new]);
    [OCMStub([mock createWithSuccess:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)() = nil;
        [invocation getArgument:&successBlock atIndex:2];
        successBlock();
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"create"];
    [mock create]
    .then(^(){
        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
        //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}

//-(PMKPromise*)delete;
- (void)testDelete {
    
    id mock = OCMPartialMock([MMXChannel new]);
    [OCMStub([mock deleteWithSuccess:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)() = nil;
        [invocation getArgument:&successBlock atIndex:2];
        successBlock();
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"delete"];
    [mock delete]
    .then(^(){
        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
        //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}


//-(PMKPromise*)subscribe;
- (void)testSubscribe {
    
    id mock = OCMPartialMock([MMXChannel new]);
    [OCMStub([mock subscribeWithSuccess:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)() = nil;
        [invocation getArgument:&successBlock atIndex:2];
        successBlock();
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"subscribe"];
    [mock subscribe]
    .then(^(){
        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
        //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}


//-(PMKPromise*)unSubscribe;
- (void)testUnSubscribe {
    
    id mock = OCMPartialMock([MMXChannel new]);
    [OCMStub([mock unSubscribeWithSuccess:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)() = nil;
        [invocation getArgument:&successBlock atIndex:2];
        successBlock();
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"unsubscribe"];
    [mock unSubscribe]
    .then(^(){
        [expectation fulfill];
    })
    .catch(^(NSError *error){
        XCTAssertNotNil(error);
        NSLog(@"%@", error);
        //Ignore any errors from authentication
    })
    .finally(^(){
    });
    
    [self waitForExpectationsWithTimeout:1 handler:^(NSError *error) {
        XCTAssertNil(error);
    }];
}


//+(PMKPromise*)subscribedChannels;
//-(PMKPromise*)subscribers;
//-(PMKPromise*)publish:(NSDictionary *)messageContent;
//-(PMKPromise*)fetchMessagesBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate limit:(int)limit ascending:(BOOL)ascending;
//-(PMKPromise*)inviteUser:(MMXUser *)user comments:(NSString *)comments;


//MMXInvite
//-(PMKPromise*)acceptWithComments:(NSString *)comments;
//-(PMKPromise*)declineWithComments:(NSString *)comments;
//
//MMXMessage
//-(PMKPromise*)send;
//-(PMKPromise*)replyWithContent:(NSDictionary *)content;
//-(PMKPromise*)replyAllWithContent:(NSDictionary *)content;
//
//MMXUser
//-(PMKPromise*)registerWithCredential:(NSURLCredential *)credential;
//+(PMKPromise*)logInWithCredential:(NSURLCredential *)credential;
//+(PMKPromise*)logOut;
//-(PMKPromise*)changePasswordWithCredential:(NSURLCredential *)credential;
//+(PMKPromise*)findByDisplayName:(NSString *)displayName limit:(int)limit;
//+(PMKPromise*)userForUsername:(NSString *)username;

@end
