//
//  Course+CoreDataProperties.swift
//  Falta Muito?
//
//  Created by Jose Neves on 08/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var name: String?
    @NSManaged public var notes: Int16
    @NSManaged public var period: Period?
    
    public func createEntity(array: [String: AnyObject]) -> Course? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "Course", into: context) as? Course {
            entity.name = array["name"] as? String
            entity.notes = (array["notes"] as? Int16)!
            entity.period = array["period"] as? Period
            return entity
        }
        else {
            return nil
        }
    }
}
