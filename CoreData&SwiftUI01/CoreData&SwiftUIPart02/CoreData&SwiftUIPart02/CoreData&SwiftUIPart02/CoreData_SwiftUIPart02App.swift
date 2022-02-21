//
//  CoreData_SwiftUIPart02App.swift
//  CoreData&SwiftUIPart02
//
//  Created by Petro Onishchuk on 2/21/22.
//

import SwiftUI

@main
struct CoreData_SwiftUIPart02App: App {

    var body: some Scene {
        let persistenceController = PersistenceController.shared
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
