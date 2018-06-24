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

    @NSManaged public var max: Float
    @NSManaged public var name: String?
    @NSManaged public var weight: Float
    @NSManaged public var average: Float
    @NSManaged public var method: Int16
    
    public func createEntity(array: [String: AnyObject]) -> NoteTemplate? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: String(describing: type(of: NoteTemplate())), into: context) as? NoteTemplate {
            entity.max = (array["max"] as? Float)!
            entity.name = array["name"] as? String
            entity.weight = (array["weight"] as? Float)!
            entity.average = (array["average"] as? Float)!
            entity.method = (array["method"] as? Int16)!
            return entity
        }
        else {
            return nil
        }
    }
}
