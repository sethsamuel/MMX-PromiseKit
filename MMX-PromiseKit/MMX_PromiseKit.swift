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
            self.findByTags(tags as Set<NSObject>,
                success: { (count : Int32, channels: [AnyObject]!) -> Void in
                    fulfill(count, channels as! [MMXChannel])
                },
                failure: { (error : NSError!) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    class func channelsStartingWithName (name : String, limit: Int32) -> Promise<(Int32, [MMXChannel])>{
        return Promise { fulfill, reject in
            self.channelsStartingWith(name, limit: limit,
                success: { (count, channels) -> Void in
                    fulfill(count, channels as! [MMXChannel])
                },
                failure : { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    func tags() -> Promise<Set<String>>{
        return Promise {fulfill, reject in
            self.tagsWithSuccess({ (tags : Set<NSObject>!) -> Void in
                fulfill(tags as! Set<String>)
            }, failure: { (error) -> Void in
                reject(error)
            })
        }
    }

    func setTags(tags : Set<String>) -> Promise<Void> {
        return Promise {fulfill, reject in
            self.setTags(tags.castToNSObject()
                , success: { () -> Void in
                    fulfill()
                }
                , failure : { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    func create() -> Promise<Void> {
        return Promise {fulfill, reject in
            self.createWithSuccess({ () -> Void in
                fulfill()
            }, failure: { (error) -> Void in
                reject(error)
            })
        }
    }

    func delete() -> Promise<Void> {
        return Promise {fulfill, reject in
            self.deleteWithSuccess({ () -> Void in
                fulfill()
                }, failure: { (error) -> Void in
                    reject(error)
            })
        }
    }

    func subscribe() -> Promise<Void> {
        return Promise {fulfill, reject in
            self.subscribeWithSuccess({ () -> Void in
                fulfill()
                }, failure: { (error) -> Void in
                    reject(error)
            })
        }
    }

    func unSubscribe() -> Promise<Void> {
        return Promise {fulfill, reject in
            self.unSubscribeWithSuccess({ () -> Void in
                fulfill()
                }, failure: { (error) -> Void in
                    reject(error)
            })
        }
    }
    
    class func subscribedChannels() -> Promise<[MMXChannel]>{
        return Promise { fulfill, reject in
            self.subscribedChannelsWithSuccess({ channels -> Void in
                fulfill(channels as! [MMXChannel])
            }, failure: { (error) -> Void in
                reject(error)
            })
        }
    }
    
    func subscribers() -> Promise<(Int32,[MMXUser])>{
        return Promise { fulfill, reject in
            self.subscribersWithSuccess({ (count, subscribers) -> Void in
                fulfill(count, subscribers as! [MMXUser])
            }, failure: { (error) -> Void in
                reject(error)
            })
        }
    }
    
    func publishMessageContent(messageContent:[String:AnyObject]!) -> Promise<MMXMessage>{
        return Promise { fulfill, reject in
        self.publish(messageContent as [NSObject : AnyObject],
                success: { (message) -> Void in
                    fulfill(message)
                },
                failure: { (error) -> Void in
                    reject(error)
            })
        }
    }

    func fetchMessagesBetweenStartDate(startDate : NSDate, endDate : NSDate, limit : Int32, ascending: Bool) -> Promise<(Int32, [MMXMessage])>{
        return Promise { fulfill, reject in
            self.fetchMessagesBetweenStartDate(startDate, endDate: endDate, limit: limit, ascending: ascending, success: { (count, messages) -> Void in
                fulfill(count, messages as! [MMXMessage])
                },
                failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    func inviteUser(user : MMXUser, comments : String) -> (String, Promise<MMXInvite>){
        let (promise, fulfill, reject) = Promise<MMXInvite>.defer()
        let messageId = self.inviteUser(user, comments: comments,
            success: { (invite) -> Void in
                fulfill(invite)
            },
            failure: { (error) -> Void in
                reject(error)
            }
        )

        return (messageId, promise)
    }

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
