//
//  NoteTemplatePresenter.swift
//  Falta Muito?
//
//  Created by Jose Neves on 09/04/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import CoreData

class NoteTemplatePresenter {
    
    private let coreDataService: CoreDataService
    
    init() {
        self.coreDataService = CoreDataService()
    }
    
    func saveNoteTemplates(noteTemplates: [[String: Any]]) -> [NoteTemplate] {
        var noteTemplatesObj = [NoteTemplate]()
        
        for noteTemplate in noteTemplates {
            noteTemplatesObj.append(NoteTemplate().createEntity(array: noteTemplate as [String: AnyObject])!)
        }
        CoreDataService().saveData()
        
        return noteTemplatesObj
    }
    
    func getNotesTemplates(noteTemplates: @escaping ([NoteTemplate]) -> Void) -> Void {
        self.coreDataService.getDataByEntity(entityName: "NoteTemplate") { (noteTemplateList) in
            
            if let resultNoteTemplate = noteTemplateList as? [NoteTemplate] {
                noteTemplates(resultNoteTemplate)
            }
        }
    }
}
