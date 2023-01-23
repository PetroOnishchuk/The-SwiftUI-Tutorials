//
//  AppDelegate.swift
//  ToDoAppSwiftUIFirebase
//
// Created by Petro Onishchuk on 12/23/22.T
//

import Foundation
import Firebase
 
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
