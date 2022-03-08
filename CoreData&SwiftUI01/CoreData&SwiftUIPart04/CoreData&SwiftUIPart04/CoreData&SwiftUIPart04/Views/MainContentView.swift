//
//  MainContentView.swift
//  CoreData&SwiftUIPart04
//
//  Created by Petro Onishchuk  
//

import SwiftUI

struct MainContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
 
    @FetchRequest(entity: Book.entity(), sortDescriptors: [], predicate: nil, animation: .default)
   
    private var allBooks: FetchedResults<Book>
    
  
    var body: some View {
        NavigationView {
            List {
                ForEach(allBooks){ book in
                    VStack(alignment: .leading) {
                        Text(book.titleOfBook)
                        Text(book.nameOfAuthor)
                      
                        Text(book.dateOfPublication)
                        
                    }
                }
                .onDelete(perform:
                            deleteBook
                )
            }.navigationTitle(Text("List of Books"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            NewBookView()
                        } label: {
                            Label("Add Book View", systemImage: "plus")
                        }
                    }
                }
        }
    }
   
    private func deleteBook(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                allBooks[$0]
            }.forEach(viewContext.delete(_:))
            
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
//    private let bookFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .medium
//        return formatter
//    }()
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        MainContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

