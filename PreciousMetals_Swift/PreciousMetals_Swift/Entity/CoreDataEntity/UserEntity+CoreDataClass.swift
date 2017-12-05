//
//  UserEntity+CoreDataClass.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/27.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObjectSub {
    override public class func getEntityName() -> String {
        return "UserEntity"
    }
}
