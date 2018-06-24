//
//  Period+CoreDataProperties.swift
//  Falta Muito?
//
//  Created by Jose Neves on 08/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//
//

import Foundation
import CoreData


extension Period {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Period> {
        return NSFetchRequest<Period>(entityName: "Period")
    }

    @NSManaged public var averageNote: Float
    @NSManaged public var courses: Int16
    @NSManaged public var maxNote: Float
    @NSManaged public var name: String?
    
    public func createEntity(array: [String: AnyObject]) -> Period? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "Period", into: context) as? Period {
            entity.averageNote = (array["averageNote"] as? Float)!
            entity.courses = (array["courses"] as? Int16)!
            entity.maxNote = (array["maxNote"] as? Float)!
            entity.name = array["name"] as? String
            return entity
        }
        else {
            return nil
        }
    }

}
