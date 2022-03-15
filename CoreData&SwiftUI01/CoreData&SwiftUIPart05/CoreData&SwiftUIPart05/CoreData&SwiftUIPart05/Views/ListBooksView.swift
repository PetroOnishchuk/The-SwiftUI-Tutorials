//
//  ListBooksView.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk on 3/15/22.
//

import SwiftUI

struct ListBooksView: View {
    
    @EnvironmentObject var myBooksAppVM: MyBooksAppViewModel
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)], predicate: nil, animation: .default)
    private var allBooks: FetchedResults<Book>
    
    var body: some View {
        ForEach(0..<allBooks.count, id:\.self){ number in
            NavigationLink {
                DetailBookView(selectedBook: allBooks[number])
            } label: {
                HStack {
                    Text("#\(number + 1)")
                    VStack(alignment: .leading) {
                        Text("Title: \(allBooks[number].titleOfBook)")
                        Text("Author: \(allBooks[number].nameOfAuthor)")
                        Text("Published: \(allBooks[number].dateOfPublication)")
                    }
                }
            }
        }.onDelete(perform: deleteBook(offsets:))
    }
    
    private func deleteBook(offsets: IndexSet) {
        withAnimation {
            offsets.map({allBooks[$0]})
                .forEach(viewContext.delete(_:))
            
            do {
                try viewContext.save()
                
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error) \(error.userInfo)")
            }
        }
    }
}

struct ListBooksView_Previews: PreviewProvider {
    static var previews: some View {
        ListBooksView()
    }
}
