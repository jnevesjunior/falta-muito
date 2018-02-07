//
//  CoreDataService.swift
//  Falta Muito?
//
//  Created by Jose Neves on 07/02/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import CoreData

class CoreDataService {
    
    private var context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    public func saveData() {
        do {
            try self.context.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func clearDataByEntity(entityName: String) {
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            do {
                let objects  = try self.context.fetch(fetchRequest) as? [NSManagedObject]
                _ = objects.map{$0.map{self.context.delete($0)}}
                CoreDataStack.sharedInstance.saveContext()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func getDataByEntity(entityName: String, completion: @escaping ([Any]) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let results = try CoreDataStack.sharedInstance.persistentContainer.viewContext.fetch(fetchRequest)
            
            return completion(results)
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
