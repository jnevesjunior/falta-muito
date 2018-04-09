//
//  Note+CoreDataProperties.swift
//  Falta Muito?
//
//  Created by Jose Neves on 08/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var value: Double
    @NSManaged public var course: Course?
    @NSManaged public var noteTemplate: NoteTemplate?

    public func createEntity(array: [String: AnyObject]) -> Note? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as? Note {
            entity.value = (array["value"] as? Double)!
            entity.course = array["course"] as? Course
            entity.noteTemplate = array["noteTemplate"] as? NoteTemplate
            return entity
        }
        else {
            return nil
        }
    }
}
