//
//  NewBookView.swift
//  CoreData&SwiftUIPart03StartPoint
//
//  Created by Petro Onishchuk on 2/22/22.
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var title = ""
    @State private var author = ""
    @State private var publicationDate = Date()
    var body: some View {
        List {
            TextField("Book Title", text: $title)
            TextField("Book Author", text: $author)
            DatePicker("Publication Date", selection: $publicationDate, in: ...Date(), displayedComponents: .date)
                .datePickerStyle(.compact)
        }.navigationTitle(Text("Create a new Book"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addBook()
                    } label: {
                        Text("Add Book")
                    }.disabled(self.title.isEmpty || self.author.isEmpty)
                }
            }
    }
    
    private func addBook() {
        withAnimation {
            let newBook = Book(context: viewContext)
            newBook.title = title
            newBook.author = author
            newBook.publicationDate = publicationDate
            
            do {
                try viewContext.save()
                self.presentation.wrappedValue.dismiss()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}
