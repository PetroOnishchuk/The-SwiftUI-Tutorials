//
//  ListBooksView.swift
//  CoreData&SwiftUIPart04
//
//  Created by Petro Onishchuk
//

import SwiftUI 

struct ListBooksView: View {
    @EnvironmentObject var myBooksAppVM: MyBooksAppViewModel
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(key: "title", ascending: true)], predicate: nil, animation: .default)
    private var allBooks: FetchedResults<Book>
    
    var body: some View {
        ForEach(allBooks) {
            book in
            VStack(alignment: .leading) {
                Text(book.titleOfBook)
                Text(book.nameOfAuthor)
                Text(book.dateOfPublication)
            }
        }
        .onDelete(perform: deleteBook(offsets:))
    }
    
    private func deleteBook(offsets: IndexSet) {
        withAnimation {
            offsets.map({allBooks[$0]}).forEach(viewContext.delete(_:))
            
            do {
                try viewContext.save()
                
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error) \(error.userInfo)")
            }
        }
    }
    
    init(inputDescription: DescriptorsCollections, inputPredicate: String, predicateDate: Date) {
        
        if inputDescription == DescriptorsCollections.publicationDate {
            let calendar = Calendar.current
            let startDate = calendar.startOfDay(for: predicateDate)
            let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            
            let predicate = NSPredicate(format: "publicationDate >= %@ AND publicationDate <= %@", startDate as NSDate, endDate as NSDate)
            self._allBooks = FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(key: inputDescription.rawValue, ascending: true)], predicate: predicate, animation: .default)
        } else {
            
            switch (inputDescription.rawValue, inputPredicate) {
                
            case let (myDescription, myPredicate) where myDescription.isEmpty && !myPredicate.isEmpty:
                self._allBooks = FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(key: myDescription, ascending: true)], predicate: NSPredicate(format: "author CONTAINS[c] %@", myPredicate), animation: .default)
            
            case let (myDescription, myPredicate) where !myDescription.isEmpty:
                self._allBooks = FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(key: myDescription, ascending: true),], predicate: NSPredicate(format: "author CONTAINS[c] %@", myPredicate), animation: .default)
            case let (myDescription, myPredicate) where !myDescription.isEmpty && myPredicate.isEmpty:
                self._allBooks = FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(key:myDescription, ascending: true)], predicate: nil, animation: .default)
            
            default:
                self._allBooks = FetchRequest(entity: Book.entity(), sortDescriptors: [], predicate: nil, animation: .default)
            }
        }
        
    }
    
}

//struct ListBooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListBooksView()
//    }
//}
