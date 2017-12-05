//
//  ConfigEntity+CoreDataProperties.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/8/1.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation
import CoreData


extension ConfigEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConfigEntity> {
        return NSFetchRequest<ConfigEntity>(entityName: getEntityName())
    }

    @NSManaged public var key: String?
    @NSManaged public var value: String?

}
