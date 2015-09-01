//
//  MMX+PromiseKit.swift
//  MMX-PromiseKit
//
//  Created by Seth on 8/31/15.
//  Copyright (c) 2015 Seth Samuel. All rights reserved.
//

import PromiseKit
import MMX

public extension MMXChannel {
    class func findByTags (tags : Set<String>!) -> Promise<(Int32, [MMXChannel])> {
        return Promise { fulfill, reject in
            self.findByTags(tags.castToNSObject(),
                success: { (count : Int32, channels: [AnyObject]!) -> Void in
                    fulfill(count, channels as! [MMXChannel])
                },
                failure: { (error : NSError!) -> Void in
                    reject(error)
                }
            )
        }
    }

//    @interface MMXChannel (PromiseKit)
//    +(PMKPromise*)channelsStartingWith:(NSString *)name limit:(int)limit;
//    +(PMKPromise*)findByTags:(NSSet*)tags;
//    -(PMKPromise*)tags;
//    -(PMKPromise*)setTags:(NSSet*)tags;
//    -(PMKPromise*)create;
//    -(PMKPromise*)delete;
//    -(PMKPromise*)subscribe;
//    -(PMKPromise*)unSubscribe;
//    +(PMKPromise*)subscribedChannels;
//    -(PMKPromise*)subscribers;
//    -(PMKPromise*)publish:(NSDictionary *)messageContent;
//    -(PMKPromise*)fetchMessagesBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate limit:(int)limit ascending:(BOOL)ascending;
//    -(PMKPromise*)inviteUser:(MMXUser *)user comments:(NSString *)comments;
//    @end
//    
//    @interface MMXInvite (PromiseKit)
//    -(PMKPromise*)acceptWithComments:(NSString *)comments;
//    -(PMKPromise*)declineWithComments:(NSString *)comments;
//    @end
//    
//    @interface MMXMessage (PromiseKit)
//    -(PMKPromise*)send;
//    -(PMKPromise*)replyWithContent:(NSDictionary *)content;
//    -(PMKPromise*)replyAllWithContent:(NSDictionary *)content;
//    @end
//    
//    @interface MMXUser (PromiseKit)
//    -(PMKPromise*)registerWithCredential:(NSURLCredential *)credential;
//    +(PMKPromise*)logInWithCredential:(NSURLCredential *)credential;
//    +(PMKPromise*)logOut;
//    -(PMKPromise*)changePasswordWithCredential:(NSURLCredential *)credential;
//    +(PMKPromise*)findByDisplayName:(NSString *)displayName limit:(int)limit;
//    +(PMKPromise*)userForUsername:(NSString *)username;
//    @end
}
