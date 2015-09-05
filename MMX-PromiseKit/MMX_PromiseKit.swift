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

}

public extension MMXInvite{
    func acceptWithComments(comments : String) -> Promise<Void>{
        return Promise { fulfill, reject in
            self.acceptWithComments(comments,
                success: { () -> Void in
                    fulfill()
                }, failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }

    func declineWithComments(comments : String) -> Promise<Void>{
        return Promise { fulfill, reject in
            self.declineWithComments(comments,
                success: { () -> Void in
                    fulfill()
                }, failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }

}

public extension MMXMessage{
    func send() -> (String, Promise<Void>){
        let (promise, fulfill, reject) = Promise<Void>.defer()
        let messageId = self.sendWithSuccess(
            { () -> Void in
                fulfill()
            },
            failure: { (error) -> Void in
                reject(error)
            }
        )
        
        return (messageId, promise)
    }
    
    func replyWithContent(content : [String:AnyObject]!) -> (String, Promise<Void>){
        let (promise, fulfill, reject) = Promise<Void>.defer()
        let messageId = self.replyWithContent(content,
            success: { () -> Void in
                fulfill()
            },
            failure: { (error) -> Void in
                reject(error)
            }
        )
        
        return (messageId, promise)
    }
    
    func replyAllWithContent(content : [String:AnyObject]!) -> (String, Promise<Void>){
        let (promise, fulfill, reject) = Promise<Void>.defer()
        let messageId = self.replyAllWithContent(content,
            success: { () -> Void in
                fulfill()
            },
            failure: { (error) -> Void in
                reject(error)
            }
        )
        
        return (messageId, promise)
    }
}

public extension MMXUser{
    func registerWithCredential(credential : NSURLCredential) -> Promise<Void>{
        return Promise { fulfill, reject in
            self.registerWithCredential(credential,
                success: { () -> Void in
                    fulfill()
                }, failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    class func logInWithCredential(credential : NSURLCredential) -> Promise<MMXUser>{
        return Promise { fulfill, reject in
            self.logInWithCredential(credential,
                success: { (user) -> Void in
                    fulfill(user)
                }, failure: { (error) -> Void in
                    reject(error)
            })
        }
    }
    
    class func logOut() -> Promise<Void>{
        return Promise { fulfill, reject in
            self.logOutWithSuccess({ () -> Void in
                fulfill()
                },
                failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    func changePasswordWithCredential(credential : NSURLCredential) -> Promise<Void>{
        return Promise { fulfill, reject in
            self.changePasswordWithCredential(credential,
                success: { () -> Void in
                    fulfill()
                }, failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    class func findByDisplayName(displayName : String, limit : Int32) -> Promise<(Int32, [MMXUser])>{
        return Promise { fulfill, reject in
            self.findByDisplayName(displayName, limit: limit,
                success: { (count, users) -> Void in
                    fulfill(count, users as! [MMXUser])
                },
                failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
    
    class func userForUsername(username : String) -> Promise<MMXUser>{
        return Promise { fulfill, reject in
            self.userForUsername(username,
                success: { (user) -> Void in
                    fulfill(user)
                },
                failure: { (error) -> Void in
                    reject(error)
                }
            )
        }
    }
}

//    @interface MMXUser (PromiseKit)
//    +(PMKPromise*)userForUsername:(NSString *)username;
//    @end

