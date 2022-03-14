//
//  CoreData_SwiftUIPart03App.swift
//  CoreData&SwiftUIPart03
//
//  Created by Petro Onishchuk on 2/22/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart03App: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene { 
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
