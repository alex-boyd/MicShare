//
//  AppDelegate.swift
//  MicShare
//
//  Created by alex on 3/9/19.
//  Copyright © 2019 gameplaySituationsInc. All rights reserved.
//
//
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseUI


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        // authentication init
        Auth.auth().createUser(withEmail: "test@fuck.com", password: "12345678") { authResult, error in
            // ...
            print(authResult)
        }
        
        // file storage init
        let storage = Storage.storage()
        
        let storageRef = storage.reference()
        let fuckRef = storageRef.child("images/fuck.png")
        
        let localFile = URL(fileReferenceLiteralResourceName: "fuck.png")
        print("localFile: ",localFile)
        let uploadTask = fuckRef.putFile(from: localFile, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print(error)
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    print(error)
                    return
                }
            }
        }
        
        // firestore database init
        let db = Firestore.firestore()

        db.collection("tests").document("oh").setData([
            "fuck": "this"
        ]) { (error:Error?) in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                print("Document was successfully created and written.")
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

