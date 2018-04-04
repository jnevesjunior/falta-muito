//
//  Note+CoreDataProperties.swift
//  Falta Muito?
//
//  Created by Jose Neves on 09/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var max: Double
    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var course: Course?

    public func createEntity(array: [String: AnyObject]) -> Note? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as? Note {
            entity.name = array["name"] as? String
            entity.max = (array["max"] as? Double)!
            entity.weight = (array["weight"] as? Double)!
            entity.course = array["course"] as? Course
            return entity
        }
        else {
            return nil
        }
    }
}
