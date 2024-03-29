//
//  CoreData_SwiftUIPart04StartPointApp.swift
//  CoreData&SwiftUIPart04StartPoint
//
//  Created by Petro Onishchuk  
//

import SwiftUI

@main
struct CoreData_SwiftUIPart04StartPointApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene { 
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
