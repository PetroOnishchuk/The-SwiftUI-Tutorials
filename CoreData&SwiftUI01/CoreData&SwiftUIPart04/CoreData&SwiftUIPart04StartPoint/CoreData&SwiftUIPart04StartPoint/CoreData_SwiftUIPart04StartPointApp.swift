//
//  CoreData_SwiftUIPart04StartPointApp.swift
//  CoreData&SwiftUIPart04StartPoint
//
//  Created by Petro Onishchuk  
//

import SwiftUI

@main
struct CoreData_SwiftUIPart04StartPointApp: App {
    var body: some Scene {
        let persistenceController = PersistenceController.shared
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
