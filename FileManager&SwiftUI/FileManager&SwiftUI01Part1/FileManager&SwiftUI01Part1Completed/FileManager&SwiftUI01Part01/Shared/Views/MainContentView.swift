//
//  MainContentView.swift
//  Shared
//
//  Created by Petro Onishchuk on 9/17/21.
//

import SwiftUI

struct MainContentView: View {
    
    @StateObject var myAppVM: MyAppViewModel = MyAppViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink("Create & Delete Folder") {
                        NewFolderView(myAppVM: myAppVM)
                    }
                } header: {
                    Text("Part #1. Create and Delete New Folder")
                }
                
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("File Manager & SwiftUI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
