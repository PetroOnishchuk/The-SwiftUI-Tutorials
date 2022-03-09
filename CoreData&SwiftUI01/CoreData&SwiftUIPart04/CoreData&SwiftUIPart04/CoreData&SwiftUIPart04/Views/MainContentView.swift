//
//  MainContentView.swift
//  CoreData&SwiftUIPart04
//
//  Created by Petro Onishchuk  
//

import SwiftUI

struct MainContentView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(entity: Book.entity(), sortDescriptors: [], predicate: nil, animation: .default)
//
//    private var allBooks: FetchedResults<Book>
    @EnvironmentObject var myBooksAppVM: MyBooksAppViewModel
    
     
    var body: some View {
        NavigationView {
            List {
                Picker("Selected descriptors", selection: $myBooksAppVM.selectedDescriptors) {
                    ForEach(DescriptorsCollections.allCases, id: \.self) {
                        Text(myBooksAppVM.takeNameDescriptors(selected: $0))
                    }
                }
                .pickerStyle(.segmented)
                if myBooksAppVM.selectedDescriptors == .publicationDate {
                    DatePicker("Publication Date", selection: $myBooksAppVM.predicateDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(.compact)
                } else {
                    TextField("Search by Author", text: $myBooksAppVM.textForPredicate)
                }
                ListBooksView(inputDescription: myBooksAppVM.selectedDescriptors, inputPredicate: myBooksAppVM.textForPredicate, predicateDate: myBooksAppVM.predicateDate)
           
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
   
  
 
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistenceController = PersistenceController.shared
        MainContentView()
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

