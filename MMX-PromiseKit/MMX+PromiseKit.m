//
//  MMX+PromiseKit.m
//  MMX-PromiseKit
//
//  Created by Seth on 8/26/15.
//  Copyright (c) 2015 Seth Samuel. All rights reserved.
//

#import "MMX+PromiseKit.h"
#import "PromiseKit.h"

@implementation MMX (PromiseKit)

@end

@implementation MMXChannel (PromiseKit)
/**
 @return int totalCount, NSArray *channels
 **/
+(PMKPromise *)channelsStartingWith:(NSString *)name limit:(int)limit{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [MMXChannel channelsStartingWith:name limit:limit success:^(int totalCount, NSArray *channels) {
            resolve(PMKManifold(totalCount, channels));
        } failure:^(NSError *error) {
            resolve(error);
        }];
    }];
}
@end