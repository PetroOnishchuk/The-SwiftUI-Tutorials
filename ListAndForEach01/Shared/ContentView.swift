//
//  ContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 2/7/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var randomNumbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55]
    
    
    var body: some View {
        List {
            ForEach(randomNumbers, id: \.self) { number in
                Text("Hello, \(number)")
            }
            .onDelete(perform: deleteItem(index:))
        }
        .padding(.top, 20)
    }
    
    func deleteItem(index: IndexSet) {
        self.randomNumbers.remove(atOffsets: index)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
