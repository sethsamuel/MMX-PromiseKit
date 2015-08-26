//
//  MMX+PromiseKit.h
//  MMX-PromiseKit
//
//  Created by Seth on 8/26/15.
//  Copyright (c) 2015 Seth Samuel. All rights reserved.
//

#import <MMX/MMX.h>

@class PMKPromise;

@interface MMX (PromiseKit)

@end

@interface MMXChannel (PromiseKit)
+(PMKPromise*)channelsStartingWith:(NSString *)name limit:(int)limit;
@end