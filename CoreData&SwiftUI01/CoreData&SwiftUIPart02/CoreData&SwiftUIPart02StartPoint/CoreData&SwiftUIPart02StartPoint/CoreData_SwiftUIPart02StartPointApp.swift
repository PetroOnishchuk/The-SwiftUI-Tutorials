//
//  CoreData_SwiftUIPart02StartPointApp.swift
//  CoreData&SwiftUIPart02StartPoint
//
//  Created by Petro Onishchuk on 2/21/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart02StartPointApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
