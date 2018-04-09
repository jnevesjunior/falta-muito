//
//  NotePresenter.swift
//  Falta Muito?
//
//  Created by Jose Neves on 02/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import CoreData

class NotePresenter {
    
    private let coreDataService: CoreDataService
    
    init() {
        self.coreDataService = CoreDataService()
    }
    
    func getNotes(course: Course, notes: @escaping ([Note]) -> Void) -> Void {
        self.coreDataService.getDataByEntity(entityName: "Note") { (notesList) in
            let notesFiltered = (notesList as NSArray).filtered(using: NSPredicate(format: "course == %@", course))
            
            if let resultNotes = notesFiltered as? [Note] {
                notes(resultNotes)
            }
        }
    }
    
    func saveNotes(notes: [[String: Any]], courses: [Course]) -> [Note] {
        var notesObj = [Note]()
        
        for note in notes {
            var noteArray = note
            
            for course in courses {
                noteArray["course"] = course
                notesObj.append(Note().createEntity(array: noteArray as [String: AnyObject])!)
            }
        }
        
        return notesObj
    }
    
    func getProgress(note: Note) -> Float {
        let progress = (note.noteTemplate?.weight)!/(note.noteTemplate?.max)!
        
        return Float(progress)
    }
}
