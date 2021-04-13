//
//  ContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 4/9/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var allCatFacts = [CatFact]()
    
    var testCatFacts = [
        CatFact(id: "1", text: "First", dateUpdated: Date()),
        CatFact(id: "2", text: "Second", dateUpdated: Date()),
        CatFact(id: "3", text: "Third", dateUpdated: Date()),
        CatFact(id: "4", text: "Forth", dateUpdated: Date()),
        CatFact(id: "5", text: "Fifth", dateUpdated: Date()),
        CatFact(id: "6", text: "Sixth", dateUpdated: Date()),
        CatFact(id: "7", text: "Seventh", dateUpdated: Date()),
        CatFact(id: "8", text: "Eighth", dateUpdated: Date()),
        CatFact(id: "9", text: "Ninth", dateUpdated: Date()),
        CatFact(id: "10", text: "Tenth", dateUpdated: Date()),
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allCatFacts.enumerated().reversed().reversed(), id: \.offset) { number, catFact in
                    Section(header: Text("Fact #\(number + 1)")
                                .font(.system(size: 17, weight: .bold, design: .default))
                                .foregroundColor(Color.red)) {
                        VStack {
                            Text("Date updated: \(catFact.modifiedDateUpdated)")
                                .foregroundColor(Color.green)
                                .padding()
                            Text(catFact.text)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(Text("Cat facts. Count: \(allCatFacts.count)"))
            .onAppear {
                CatFactURLSession.shared.loadFacts { catFacts in
                    self.allCatFacts = catFacts
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
