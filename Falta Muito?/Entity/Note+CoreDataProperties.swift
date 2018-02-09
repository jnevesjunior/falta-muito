//
//  Note+CoreDataProperties.swift
//  Falta Muito?
//
//  Created by Jose Neves on 08/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var name: String?
    @NSManaged public var max: Double
    @NSManaged public var course: Course?

}
