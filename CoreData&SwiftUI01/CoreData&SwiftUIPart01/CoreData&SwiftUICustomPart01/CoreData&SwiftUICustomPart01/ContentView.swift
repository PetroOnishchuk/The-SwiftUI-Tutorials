//
//  ContentView.swift
//  CoreData&SwiftUICustomPart01
//
//  Created by Petro Onishchuk on 2/20/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    //    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)], predicate: nil, animation: .default)
    @FetchRequest(entity: Book.entity(), sortDescriptors: [], predicate: nil, animation: .default)
    private var allBooks: FetchedResults<Book>
    var body: some View {
        NavigationView {
            List {
                ForEach(allBooks){ book in
                    VStack(alignment: .leading) {
                        Text(book.title ?? "")
                        Text(book.author ?? "")
                        Text(book.publicationDate ?? Date(), formatter: bookFormatter)
                    }
                }
                .onDelete(perform:
                            deleteBook
                )
            }.navigationTitle(Text("List of Books"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addBook) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
        }
    }
    
    private func addBook() {
        withAnimation {
            let newBook = Book(context: viewContext)
            newBook.title = "Testing book title"
            newBook.author = "Testing book author"
            newBook.publicationDate = Date()
            
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
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
    
    private let bookFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let persistenceController = PersistenceController.shared
        ContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
