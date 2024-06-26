//
//  AppDelegate.swift
//  Intdreamer
//
//  Created by Oleksandr Smakhtin on 05/09/2023.
//

import UIKit
import CoreData
import AVFoundation
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    //MARK: - Did finish launch
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // app
        configureApp()
        // fire
        setupFirebase()
        
        return true
    }
    
    
    
    //MARK: - Firebase
    private func setupFirebase() {
        FirebaseApp.configure()
    }
    
    
    //MARK: - Setup app
    private func configureApp() {
        let beenLaunched = UserDefaults.standard.bool(forKey: "BeenLaunched")
        
        if !beenLaunched {
            UserDefaults.standard.set(true, forKey: "BeenLaunched")
            let date = Date(timeIntervalSince1970: 56)
            UserDefaults.standard.setValue(date, forKey: "lastOpenedDailyBoxScreen")
            UserDefaults.standard.setValue(0, forKey: "diaryPages")
            UserDefaults.standard.setValue(0, forKey: "dailyScore")
            UserDefaults.standard.setValue(0, forKey: "totalPhase")
            UserDefaults.standard.synchronize()
            print("First launch")
        }
    }
    
    
    

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

