//
//  CoreData_SwiftUIPart05App.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk on  
//

import SwiftUI

@main
struct CoreData_SwiftUIPart05App: App {
    
    let persistenceController = PersistenceController.shared
    @StateObject var myBooksAppVM = MyBooksAppViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(myBooksAppVM)
        }
    }
}
