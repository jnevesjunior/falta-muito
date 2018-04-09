//
//  NoteTemplate+CoreDataProperties.swift
//  Falta Muito?
//
//  Created by Jose Neves on 08/04/18.
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

}
