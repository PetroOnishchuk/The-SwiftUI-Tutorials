//
//  DetailBookView.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk
//

import SwiftUI

struct DetailBookView: View {
    let selectedBook: Book
    
    var body: some View {
        List {
            Text("Title: \(selectedBook.titleOfBook)")
            Text("Published: \(selectedBook.dateOfPublication)")
            Text("Author: \(selectedBook.nameOfAuthor)")
            NavigationLink {
                // BooksOfAuthor
            } label: {
                Text("All books of Author")
            }
        }.navigationTitle(Text("Detail of Book"))
    }
}

struct DetailBookView_Previews: PreviewProvider {
    
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        let newBook = Book(context: persistenceController.container.viewContext)
        newBook.title = "Test Book"
        newBook.publicationDate = Date()
        let newAuthor = Author(context: persistenceController.container.viewContext)
        newAuthor.name = "Test Author Name"
        newBook.author = newAuthor
        
        return DetailBookView(selectedBook: newBook)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
