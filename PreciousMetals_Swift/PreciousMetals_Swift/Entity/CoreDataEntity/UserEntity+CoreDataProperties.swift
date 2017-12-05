//
//  UserEntity+CoreDataProperties.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/27.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: getEntityName())
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?

}
