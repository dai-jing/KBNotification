//
//  KBNotificationCenter.swift
//  KBNotification
//
//  Created by Jing Dai on 6/2/16.
//  Copyright © 2016 daijing. All rights reserved.
//

import UIKit

public class KBNotificationCenter: NSObject {
    public static let defaultCenter = KBNotificationCenter()
    private let notificationsDict: NSMutableDictionary
    
    public override init() {
        self.notificationsDict = NSMutableDictionary()
    }
    
    public func kb_addObserver(observer: AnyObject, selector: Selector, name: String, object: AnyObject? = nil) {
        var selectorsDict = self.notificationsDict.objectForKey(name)
        if (selectorsDict == nil) {
            selectorsDict = NSMutableDictionary()
            selectorsDict?.setObject(observer, forKey: NSStringFromSelector(selector))
            
            self.notificationsDict.setObject(selectorsDict!, forKey: name)
        }
    }
    
    public func kb_postNotificationName(aName: String, object anObject: AnyObject?) {
        let selectorsDict = self.notificationsDict.objectForKey(aName)
        let selectorName = selectorsDict?.allKeys.first
        if (selectorName != nil) {
            let notification = KBNotification(name: aName, object: anObject, userInfo: nil)
            let observer = selectorsDict?.objectForKey(selectorName!)
            observer?.performSelector(NSSelectorFromString(selectorName as! String), withObject: notification)
        }
    }
    
    public func kb_postNotificationName(aName: String, object anObject: AnyObject?, userInfo aUserInfo: [NSObject : AnyObject]?) {
        let selectorsDict = self.notificationsDict.objectForKey(aName)
        let selectorName = selectorsDict?.allKeys.first
        if (selectorName != nil) {
            let notification = KBNotification(name: aName, object: anObject, userInfo: aUserInfo)
            let observer = selectorsDict?.objectForKey(selectorName!)
            observer?.performSelector(NSSelectorFromString(selectorName as! String), withObject: notification)
        }
    }
    
    public func kb_removeObserver(observer: AnyObject) {
        let removedNames = NSMutableArray()
        for (name, selectorsDict) in self.notificationsDict {
            for (_, aObserver) in selectorsDict as! NSMutableDictionary {
                if (aObserver .isEqual(observer)) {
                    removedNames.addObject(name)
                }
            }
        }
        
        self.notificationsDict.removeObjectsForKeys(removedNames as [AnyObject])
    }
    
    public func kb_removeObserver(observer: AnyObject, name aName: String?, object anObject: AnyObject?) {
        self.notificationsDict.removeObjectForKey(aName!)
    }
}
