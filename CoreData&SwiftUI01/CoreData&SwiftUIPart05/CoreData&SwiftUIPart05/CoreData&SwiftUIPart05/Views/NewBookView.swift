//
//  NewBookView.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk
//

import SwiftUI

struct NewBookView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var myBookAppVM: MyBooksAppViewModel
    @State private var selectedAuthor: Author? = nil
    
    var body: some View {
        List {
            TextField("Book Title", text: $myBookAppVM.bookTitle)
            
            DatePicker("Publication Date", selection: $myBookAppVM.bookDate, in: ...Date(),
                       displayedComponents: .date)
                .datePickerStyle(.compact)
            Text("Author: \(selectedAuthor?.nameOfAuthor ?? "Please, select Author")")
            NavigationLink {
                ListOfAuthorsView(selectedAuthor: $selectedAuthor)
            } label: {
                Text("Select an Author")
            }
            Button("Create Book") {
                let newBook = Book(context: viewContext)
                newBook.title = myBookAppVM.bookTitle
                newBook.publicationDate = myBookAppVM.bookDate
                if selectedAuthor != nil {
                    let newAuthor = selectedAuthor
                    newBook.author = newAuthor
                }
                
                do {
                    try viewContext.save()
                    self.presentation.wrappedValue.dismiss()
                } catch {
                    let error = error as NSError
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        }.navigationTitle(Text("Create a new Book"))
    }
}

struct NewBookView_Previews: PreviewProvider {
    static var previews: some View {
        NewBookView()
    }
}
