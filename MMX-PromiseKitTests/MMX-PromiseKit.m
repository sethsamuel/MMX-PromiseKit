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

- (void)testChannelsStartingWith {
    
    NSArray *stubChannels = @[@{},@{}];
    
    id mock = OCMClassMock([MMXChannel class]);
    [OCMStub([mock channelsStartingWith:[OCMArg any] limit:100 success:[OCMArg any] failure:[OCMArg any]]) andDo:^(NSInvocation *invocation) {
        void (^successBlock)(int count, NSArray *channels) = nil;
        [invocation getArgument:&successBlock atIndex:4];
        successBlock(2, stubChannels);
    }];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"channelsStartingWith"];
    // This is an example of a functional test case.
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


@end
