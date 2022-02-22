//
//  CoreData_SwiftUIPart03StartPointApp.swift
//  CoreData&SwiftUIPart03StartPoint
//
//  Created by Petro Onishchuk on 2/22/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart03StartPointApp: App {
    var body: some Scene {
       let persistenceController = PersistenceController.shared
        
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
