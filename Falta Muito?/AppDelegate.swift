//
//  AppDelegate.swift
//  Falta Muito?
//
//  Created by Jose Neves on 15/01/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.loadDefaultData()
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1] as URL)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        CoreDataService().saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        CoreDataService().saveData()
    }
    
    private func loadDefaultData() {
        if(!self.isAppAlreadyLaunchedOnce()) {
            let noteTemplatePresenter = NoteTemplatePresenter()
            
            var noteTempletes = [[String: Any]]()
            
            var noteTemplate1 = [String: Any]()
            noteTemplate1["name"] = "Avaliação Continuada"
            noteTemplate1["max"] = 10
            noteTemplate1["weight"] = 7
            noteTempletes.append(noteTemplate1)
            
            var noteTemplate2 = [String: Any]()
            noteTemplate2["name"] = "Avaliação Intermediaria"
            noteTemplate2["max"] = 10
            noteTemplate2["weight"] = 7
            noteTempletes.append(noteTemplate2)
            
            var noteTemplate3 = [String: Any]()
            noteTemplate3["name"] = "Avaliação Semestral"
            noteTemplate3["max"] = 10
            noteTemplate3["weight"] = 7
            noteTempletes.append(noteTemplate3)
            
            
            _ = noteTemplatePresenter.saveNoteTemplates(noteTemplates: noteTempletes)
        }
        
    }
    
    private func isAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        
        if (defaults.bool(forKey: "isAppAlreadyLaunchedOnce")) {
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            return false
        }
    }

}

