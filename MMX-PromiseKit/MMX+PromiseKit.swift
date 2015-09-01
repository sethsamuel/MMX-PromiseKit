//
//  MMX+PromiseKit.swift
//  MMX-PromiseKit
//
//  Created by Seth on 8/31/15.
//  Copyright (c) 2015 Seth Samuel. All rights reserved.
//

import Foundation
import PromiseKit
import MMX

extension MMXChannel {
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
    
}
