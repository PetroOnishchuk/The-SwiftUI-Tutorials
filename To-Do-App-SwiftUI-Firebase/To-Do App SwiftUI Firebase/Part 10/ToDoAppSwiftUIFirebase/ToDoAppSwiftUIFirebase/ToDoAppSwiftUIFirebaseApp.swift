//
//  ToDoAppSwiftUIFirebaseApp.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 12/22/22.
//
// Tom
// Thomson
//thomson888@gmail.com
//123456789
import SwiftUI

@main
struct ToDoAppSwiftUIFirebaseApp: App {
    
    //MARK: V1.0 For configure Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var myAppVM = MyAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootContentView()
                .environmentObject(myAppVM)
        }
    }
    
    // MARK: V 2.0 For configure Firebase
//    init() {
//        setupFirebase()
//    }
}
