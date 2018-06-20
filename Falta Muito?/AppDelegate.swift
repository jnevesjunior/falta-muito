//
//  AppDelegate.swift
//  Falta Muito?
//
//  Created by Jose Neves on 15/01/18.
//  Copyright © 2018 Jose Neves. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import Firebase
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.loadDefaultData()
        self.setupGoogleAnalytics()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        self.requestNotificationAuthorization(application: application)
        application.registerForRemoteNotifications()
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (greanted, error) in
            if(error != nil) {
            }
        }
        
//        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        print(urls[urls.count-1] as URL)
        
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
            noteTemplate1["weight"] = 6
            noteTemplate1["method"] = 2
            noteTemplate1["average"] = 0.25
            noteTempletes.append(noteTemplate1)
            
            var noteTemplate2 = [String: Any]()
            noteTemplate2["name"] = "Avaliação Intermediaria"
            noteTemplate2["max"] = 10
            noteTemplate2["weight"] = 6
            noteTemplate2["method"] = 2
            noteTemplate2["average"] = 0.3
            noteTempletes.append(noteTemplate2)
            
            var noteTemplate3 = [String: Any]()
            noteTemplate3["name"] = "Avaliação Semestral"
            noteTemplate3["max"] = 10
            noteTemplate3["weight"] = 6
            noteTemplate3["method"] = 2
            noteTemplate3["average"] = 0.45
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
    
    private func setupGoogleAnalytics() {
        var googleAnalyticsID = ""
        var myDict: NSDictionary?
        if let path = Bundle.main.path(forResource: "Settings", ofType: "plist") {
            myDict = NSDictionary(contentsOfFile: path)
        }
        if let dict = myDict {
            googleAnalyticsID = dict["GoogleAnalyticsID"] as! String
        }
        if let gai = GAI.sharedInstance() {
            gai.tracker(withTrackingId: googleAnalyticsID)
            
            // Optional: automatically report uncaught exceptions.
            gai.trackUncaughtExceptions = true
            
            // Optional: set Logger to VERBOSE for debug information.
            // Remove before app release.
            //            gai.logger.logLevel = .warning
            gai.dispatchInterval = 2
        }
    }
    
    private func requestNotificationAuthorization(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in })
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
    }
}
