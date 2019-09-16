//
//  AppDelegate.swift
//  ListMaker
//
//  Created by Padmasri Nishanth on 8/22/19.
//  Copyright © 2019 Padmasri Nishanth. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
        
        do{
            _ = try Realm()
        }catch{
            print("Error Initialising new realm\(error)")
        }
 
        return true
    }
    
}



