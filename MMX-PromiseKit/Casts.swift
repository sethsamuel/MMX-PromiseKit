//
//  Casts.swift
//  MMX-PromiseKit
//
//  Created by Seth on 8/31/15.
//  Copyright (c) 2015 Seth Samuel. All rights reserved.
//

import Foundation

extension Set{
    func castToNSObject() -> Set<NSObject>{
        var s = Set<NSObject>()
        for x in self{
            s.insert(x as! NSObject)
        }
        return s
    }
}