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
 @return NSNumber totalCount, NSArray *channels
 **/
+(PMKPromise *)channelsStartingWith:(NSString *)name limit:(int)limit{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [MMXChannel channelsStartingWith:name limit:limit success:^(int totalCount, NSArray *channels) {
            resolve(PMKManifold(@(totalCount), channels));
        } failure:resolve];
    }];
}

/**
 @return NSNumber totalCount, NSArray *channels
 **/
+(PMKPromise*) findByTags:(NSSet*)tags{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [MMXChannel findByTags:tags success:^(int totalCount, NSArray *channels) {
            resolve(PMKManifold(@(totalCount), channels));
        } failure:resolve];
    }];
}

/**
 @return NSSet *tags
 **/
-(PMKPromise*) tags{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [self tagsWithSuccess:^(NSSet *tags) {
            resolve(tags);
        } failure:resolve];
    }];
}

/**
 @return void
 **/
-(PMKPromise*) setTags:(NSSet*)tags{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [self setTags:tags success:^{
            resolve(nil);
        } failure:resolve];
    }];
}

/**
 @return void
 **/
-(PMKPromise*) create{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [self createWithSuccess:^{
            resolve(nil);
        } failure:resolve];
    }];
}

/**
 @return void
 **/
-(PMKPromise*) delete{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [self deleteWithSuccess:^{
            resolve(nil);
        } failure:resolve];
    }];
}

/**
 @return void
 **/
-(PMKPromise*) subscribe{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [self subscribeWithSuccess:^{
            resolve(nil);
        } failure:resolve];
    }];
}

/**
 @return void
 **/
-(PMKPromise*) unSubscribe{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
        [self unSubscribeWithSuccess:^{
            resolve(nil);
        } failure:resolve];
    }];
}

/**
 @return NSSet *tags
 **/
+(PMKPromise*) subscribedChannels{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}

/**
 @return NSSet *tags
 **/
-(PMKPromise*) subscribers{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}

/**
 @return NSSet *tags
 **/
-(PMKPromise*) publish:(NSDictionary *)messageContent{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}

/**
 @return NSSet *tags
 **/
-(PMKPromise*) fetchMessagesBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate limit:(int)limit ascending:(BOOL)ascending{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}

/**
 @return NSSet *tags
 **/
-(PMKPromise*) inviteUser:(MMXUser *)user comments:(NSString *)comments{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
@end

@implementation MMXInvite (PromiseKit)
/**
 @return void
 **/
-(PMKPromise*)acceptWithComments:(NSString *)comments{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}

/**
 @return void
 **/
-(PMKPromise*)declineWithComments:(NSString *)comments{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
@end

@implementation MMXMessage (PromiseKit)
/**
 @return void
 **/
-(PMKPromise*)send{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
/**
 @return void
 **/
-(PMKPromise*)replyWithContent:(NSDictionary *)content{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
/**
 @return void
 **/
-(PMKPromise*)replyAllWithContent:(NSDictionary *)content{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
@end

@implementation MMXUser (PromiseKit)
/**
 @return void
 **/
-(PMKPromise*)registerWithCredential:(NSURLCredential *)credential{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
/**
 @return void
 **/
+(PMKPromise*)logInWithCredential:(NSURLCredential *)credential{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
/**
 @return void
 **/
+(PMKPromise*)logOut{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
/**
 @return void
 **/
-(PMKPromise*)changePasswordWithCredential:(NSURLCredential *)credential{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
/**
 @return void
 **/
+(PMKPromise*)findByDisplayName:(NSString *)displayName limit:(int)limit{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
/**
 @return void
 **/
+(PMKPromise*)userForUsername:(NSString *)username{
    return [PMKPromise  promiseWithResolverBlock:^(PMKResolver resolve) {
    }];
}
@end