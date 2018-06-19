//
//  NoteTemplate+CoreDataProperties.swift
//  Falta Muito?
//
//  Created by Jose Neves on 18/06/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//
//

import Foundation
import CoreData


extension NoteTemplate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteTemplate> {
        return NSFetchRequest<NoteTemplate>(entityName: "NoteTemplate")
    }

    @NSManaged public var max: Double
    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var average: Double
    @NSManaged public var method: Int16
    
    public func createEntity(array: [String: AnyObject]) -> NoteTemplate? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: type(of: NoteTemplate())), into: context) as? NoteTemplate {
            entity.max = (array["max"] as? Double)!
            entity.name = array["name"] as? String
            entity.weight = (array["weight"] as? Double)!
            entity.average = (array["average"] as? Double)!
            entity.method = (array["method"] as? Int16)!
            return entity
        }
        else {
            return nil
        }
    }
}
