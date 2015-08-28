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
+(PMKPromise*) findByTags:(NSSet*)tags;

-(PMKPromise*) tags;

-(PMKPromise*) setTags:(NSSet*)tags;

-(PMKPromise*) create;

-(PMKPromise*) delete;

-(PMKPromise*) subscribe;

-(PMKPromise*) unSubscribe;

+(PMKPromise*) subscribedChannels;

-(PMKPromise*) subscribers;

-(PMKPromise*) publish:(NSDictionary *)messageContent;

-(PMKPromise*) fetchMessagesBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate limit:(int)limit ascending:(BOOL)ascending;

-(PMKPromise*) inviteUser:(MMXUser *)user comments:(NSString *)comments;
@end

@interface MMXInvite (PromiseKit)
-(PMKPromise*)acceptWithComments:(NSString *)comments;
-(PMKPromise*)declineWithComments:(NSString *)comments;
@end