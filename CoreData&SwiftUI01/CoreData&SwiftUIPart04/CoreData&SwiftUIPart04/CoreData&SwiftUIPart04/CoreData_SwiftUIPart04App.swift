//
//  CoreData_SwiftUIPart04App.swift
//  CoreData&SwiftUIPart04
//
//  Created by Petro Onishchuk  
//

import SwiftUI

@main
struct CoreData_SwiftUIPart04App: App {
    var body: some Scene {
        let persistenceController = PersistenceController.shared
        
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
