//
//  ListOfAuthorsView.swift
//  CoreData&SwiftUIPart05
//
//  Created by Petro Onishchuk
//

import SwiftUI

struct ListOfAuthorsView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Author.entity(), sortDescriptors: [], predicate: nil, animation: .default)
    private var allAuthors: FetchedResults<Author>
    @EnvironmentObject var myBooksAppVM: MyBooksAppViewModel
    @Binding var selectedAuthor: Author?
    
    var body: some View {
        List {
            ForEach(0..<allAuthors.count, id: \.self) {
                number in
                HStack {
                    Text("#\(number + 1)")
                    VStack(alignment: .leading) {
                        Text("Author Name: \(allAuthors[number].nameOfAuthor)")
                        
                    }
                }
                .onTapGesture {
                    selectedAuthor = allAuthors[number]
                    presentation.wrappedValue.dismiss()
                }
            }.onDelete(perform: deleteAuthor(offsets:))
        }.navigationTitle(Text("All Authors"))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink{
                        // NewAuthorView
                    } label: {
                        Label("New Author", systemImage: "plus")
                    }
                }
            }
    }
    
    private func deleteAuthor(offsets: IndexSet) {
        withAnimation {
            offsets.map({allAuthors[$0]}).forEach(viewContext.delete(_:))
            do {
                try viewContext.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error) \(error.userInfo)")
            }
        }
    }
}

struct ListOfAuthorsView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        let newAuthor = Author(context: persistenceController.container.viewContext)
        newAuthor.name = "Test Author Name"
        
        return ListOfAuthorsView(selectedAuthor: .constant(newAuthor))
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}
