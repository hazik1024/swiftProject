//
//  ConfigEntity+CoreDataClass.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/8/1.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation
import CoreData

@objc(ConfigEntity)
public class ConfigEntity: NSManagedObjectSub {
    override public class func getEntityName() -> String {
        return "ConfigEntity"
    }
}
