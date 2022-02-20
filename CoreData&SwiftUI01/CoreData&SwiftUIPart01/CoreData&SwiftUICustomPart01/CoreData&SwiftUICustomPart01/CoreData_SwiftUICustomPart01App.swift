//
//  CoreData_SwiftUICustomPart01App.swift
//  CoreData&SwiftUICustomPart01
//
//  Created by Petro Onishchuk on 2/20/22.
//

import SwiftUI

@main
struct CoreData_SwiftUICustomPart01App: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
