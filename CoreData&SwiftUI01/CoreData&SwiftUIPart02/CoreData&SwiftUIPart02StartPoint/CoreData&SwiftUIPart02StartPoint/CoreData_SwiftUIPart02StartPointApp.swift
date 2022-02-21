//
//  CoreData_SwiftUIPart02StartPointApp.swift
//  CoreData&SwiftUIPart02StartPoint
//
//  Created by Petro Onishchuk on 2/21/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart02StartPointApp: App {
    var body: some Scene {
        let persistenceController = PersistenceController.shared
        
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
