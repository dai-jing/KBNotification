//
//  KBNotification.swift
//  KBNotification
//
//  Created by Jing Dai on 6/2/16.
//  Copyright © 2016 daijing. All rights reserved.
//

import UIKit

public class KBNotification: NSObject, NSCopying, NSCoding {
    public var name: String?
    public var object: AnyObject?
    public var userInfo: [NSObject: AnyObject]?
    
    public init(name: String, object: AnyObject?, userInfo: [NSObject : AnyObject]?) {
        self.name = name
        self.object = object
        self.userInfo = userInfo
    }
    
    public func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = KBNotification(name: name!, object: object, userInfo: userInfo)
        return copy
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as? String
        self.object = aDecoder.decodeObjectForKey("object")! as AnyObject
        self.userInfo = aDecoder.decodeObjectForKey("userInfo") as? [NSObject: AnyObject]
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.object, forKey: "object")
        aCoder.encodeObject(self.userInfo, forKey: "userInfo")
    }
}
