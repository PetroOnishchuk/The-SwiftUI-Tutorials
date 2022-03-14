//
//  CoreData_SwiftUIPart03StartPointApp.swift
//  CoreData&SwiftUIPart03StartPoint
//
//  Created by Petro Onishchuk on 2/22/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart03StartPointApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene { 
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
