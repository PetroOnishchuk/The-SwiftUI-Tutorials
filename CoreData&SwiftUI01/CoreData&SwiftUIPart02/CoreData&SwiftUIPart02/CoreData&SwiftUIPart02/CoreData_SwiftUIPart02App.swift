//
//  CoreData_SwiftUIPart02App.swift
//  CoreData&SwiftUIPart02
//
//  Created by Petro Onishchuk on 2/21/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart02App: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene { 
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
