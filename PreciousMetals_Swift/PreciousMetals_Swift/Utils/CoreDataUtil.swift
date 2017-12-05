//
//  CoreDataUtil.swift
//  PreciousMetals_Swift
//
//  Created by hazik on 2017/6/23.
//  Copyright © 2017年 ksjf. All rights reserved.
//

import UIKit
import CoreData

class CoreDataUtil: NSObject {
    private let keyCoreDataThreadContext = "keyCoreDataThreadContext"
    public static let INSTANCE = CoreDataUtil()
    private override init() {
        super.init()
    }
    
    public var context: NSManagedObjectContext {
        get {
            var _context: NSManagedObjectContext
            if #available(iOS 10.0, *) {
                if Thread.current.isMainThread {
                    _context = self.persistentContainer.viewContext
                }
                else {
                    let dict = Thread.current.threadDictionary
                    if dict.object(forKey: self.keyCoreDataThreadContext) == nil {
                        _context = self.persistentContainer.newBackgroundContext()
                        //通知变动到viewContext
                        dict.setObject(_context, forKey: self.keyCoreDataThreadContext as NSCopying)
                    }
                    else {
                        _context = dict.object(forKey: self.keyCoreDataThreadContext) as! NSManagedObjectContext
                    }
                }
            }
            else {
                if Thread.current.isMainThread {
                    _context = self._mainContext
                }
                else {
                    let dict = Thread.current.threadDictionary
                    if dict.object(forKey: self.keyCoreDataThreadContext) == nil {
                        _context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
                        _context.parent = self._mainContext
                        dict.setObject(_context, forKey: self.keyCoreDataThreadContext as NSCopying)
                    }
                    else {
                        _context = dict.object(forKey: self.keyCoreDataThreadContext) as! NSManagedObjectContext
                    }
                }
            }
            return _context
        }
    }
    
    // MARK: - ios10 Core Data stack
    
    @available(iOS 10.0, *)
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MainDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - ios9.0 Core Data stack
    private lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    private lazy var manageObjectModel:NSManagedObjectModel = {
       let path = Bundle.main.url(forResource: "MainDatabase", withExtension: "momd")
        return NSManagedObjectModel(contentsOf: path!)!
    }()
    private lazy var persistentStoreCoordinator:NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.manageObjectModel)
        let path = self.applicationDocumentsDirectory.appendingPathComponent("MainDatabase.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: path, options: nil)
        } catch  {
            var dict = [String:Any]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            logdebug("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    private lazy var _rootContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        context.persistentStoreCoordinator = self.persistentStoreCoordinator
        return context
    }()
    
    private lazy var _mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.parent = self._rootContext
        return context
    }()
    
    // MARK: - 持久化context
    public func saveCurrentContext(_ wait: Bool) {
        if context.hasChanges {
            if wait {
                context.performAndWait({
                    self.saveMyContext(self.context)
                })
            }
            else {
                context.perform({
                    self.saveMyContext(self.context)
                })
            }
        }
    }
    
    public func saveContextToDatabase(_ wait: Bool) {
        if #available(iOS 10.0.0, *) {
            saveCurrentContext(wait)
            if context != persistentContainer.viewContext {
                if wait {
                    persistentContainer.viewContext.performAndWait({
                        self.saveMyContext(self.persistentContainer.viewContext)
                    })
                }
                else {
                    persistentContainer.viewContext.perform({
                        self.saveMyContext(self.persistentContainer.viewContext)
                    })
                }
            }
        }
        else {
            if context.hasChanges {
                if wait {
                    context.performAndWait({
                        self.saveMyContext(self.context)
                        self.saveDatabaseForIOS9(wait)
                    })
                }
                else {
                    context.perform({
                        self.saveMyContext(self.context)
                        self.saveDatabaseForIOS9(wait)
                    })
                }
            }
        }
    }
    
    private func saveDatabaseForIOS9(_ wait: Bool) {
        if self._mainContext.hasChanges {
            self._mainContext.performAndWait({
                self.saveMyContext(self._mainContext)
            })
        }
        if self._rootContext.hasChanges {
            if wait {
                self._rootContext.perform({
                    self.saveMyContext(self._rootContext)
                })
            }
            else {
                self._rootContext.performAndWait({
                    self.saveMyContext(self._rootContext)
                })
            }
        }
    }
    
    private func saveMyContext(_ context: NSManagedObjectContext) {
        do {
            try context.save()
        }
        catch {
            logdebug("context save failed: ", error)
        }
    }
}
