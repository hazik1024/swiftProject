//
//  NSManagedObjectSub.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/10/13.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit
import CoreData

public class NSManagedObjectSub: NSManagedObject {
    open class func getEntityName() -> String {
        return "NSManagedObjectSub"
    }
    
    //create
    public static func create() -> NSManagedObjectSub {
        let entityDesc = NSEntityDescription.entity(forEntityName: getEntityName(), in: CoreDataUtil.INSTANCE.context)
        return NSManagedObjectSub(entity: entityDesc!, insertInto: CoreDataUtil.INSTANCE.context)
    }
    //delete
    public func delete() {
        CoreDataUtil.INSTANCE.context.delete(self)
    }
    
    public static func deleteAll() {
        let results = findAll()// as [NSManagedObjectSub]
        for entity in results {
            entity.delete()
        }
    }
    
    //query
    public static func findAll() -> [NSManagedObjectSub] {
        let request = NSFetchRequest<NSManagedObjectSub>(entityName: getEntityName())
        return executeRequest(request)
    }
    
    public static func find(byKey key: String, withValue value: String) -> [NSManagedObjectSub] {
        let request = NSFetchRequest<NSManagedObjectSub>(entityName: getEntityName())
        request.predicate = NSPredicate(format: "%K = %@", key, value)
        return executeRequest(request)
    }
    
    public static func executeRequest(_ request: NSFetchRequest<NSManagedObjectSub>) -> [NSManagedObjectSub] {
        var results:[NSManagedObjectSub] = [NSManagedObjectSub]()
        CoreDataUtil.INSTANCE.context.performAndWait {
            do {
                results = try CoreDataUtil.INSTANCE.context.fetch(request)
            }
            catch {
                
            }
        }
        return results
    }
}
