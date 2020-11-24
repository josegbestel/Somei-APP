//
//  AppDelegate.swift
//  SOMEI
//
//  Created by Sergio Cordeiro on 13/08/20.
//  Copyright © 2020 SOMEI. All rights reserved.
//

import UIKit
import CoreData
import FirebaseCore
import SendBirdSDK
import SendBirdUIKit
import DirectCheckout

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SBDChannelDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Configuração do firebase para salvar as imagens
        FirebaseApp.configure()
        //Configuração Sendbird para uso do chat //Necessario troca de App_id para apresentação
        let APP_ID = "1BC26036-5B4A-40B3-8C22-07597EE25CC0"
        let USER_ID = "Usuario"
//        let CHANNEL_URL = "sendbird_open_channel_9586_ba2109976fc07f43e75e64050bda9a01d0709a38"
        SBDMain.initWithApplicationId(APP_ID)
        SBUGlobals.CurrentUser = SBUUser(userId: USER_ID)
        
        //configuração do checkout usado no fluxo de pagamento
        DirectCheckout.initialize(publicToken: "0DC3AD1B8E164B7C75D91CEB79CDED7D0DC9F06A80A23B6FA83F89203009FD32", environment: .sandbox)
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "SOMEI")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

