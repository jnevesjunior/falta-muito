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
    
    func saveNotes(noteTemplates: [NoteTemplate], courses: [Course]) -> [Note] {
        var notesObj = [Note]()
        var noteArray = [String: Any]()
        
        for course in courses {
            noteArray["value"] = 0
            noteArray["course"] = course
            
            for noteTemplate in noteTemplates {
                noteArray["noteTemplate"] = noteTemplate
                notesObj.append(Note().createEntity(array: noteArray as [String: AnyObject])!)
            }
        }
        CoreDataService().saveData()
        
        return notesObj
    }
    
    func getProgress(note: Note) -> Float {
        let progress = note.value/(note.noteTemplate?.max)!
        
        return Float(progress)
    }
}
