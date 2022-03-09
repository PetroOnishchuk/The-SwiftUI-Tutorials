//
//  CoreData_SwiftUIPart04App.swift
//  CoreData&SwiftUIPart04
//
//  Created by Petro Onishchuk  
//

import SwiftUI

@main
struct CoreData_SwiftUIPart04App: App {
    let persistenceController = PersistenceController.shared
    @StateObject var myBooksAppVM = MyBooksAppViewModel()
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(myBooksAppVM)
        }
    }
}
