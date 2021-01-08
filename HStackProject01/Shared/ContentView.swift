//
//  ContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 1/7/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ScrollView(.horizontal) {
             LazyHStack {
                ForEach(1..<101, id: \.self){ number in
                    Text("Hello, \(number)")
                        .printEach(number)
                }
            }
            .background(Color.blue)
            
        }
    }
}

extension View {
    func printEach(_ value: Any...) -> some View {
        print("\(value)")
        return self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
