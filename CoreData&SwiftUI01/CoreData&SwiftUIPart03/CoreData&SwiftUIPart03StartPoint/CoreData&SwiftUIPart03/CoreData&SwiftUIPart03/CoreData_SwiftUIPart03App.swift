//
//  CoreData_SwiftUIPart03App.swift
//  CoreData&SwiftUIPart03
//
//  Created by Petro Onishchuk on 2/22/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart03App: App {
    var body: some Scene {
        let persistenceController = PersistenceController.shared
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
