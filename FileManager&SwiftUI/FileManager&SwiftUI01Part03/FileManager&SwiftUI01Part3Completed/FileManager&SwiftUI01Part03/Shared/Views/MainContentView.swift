//
//  MainContentView.swift
//  FileManager&SwiftUI01Part02 (iOS)
//
//  Created by Petro Onishchuk on 9/23/21.
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
                Section {
                    NavigationLink("Part #2") {
                       SecondPartView(myAppVM: myAppVM)
                    }
                } header: {
                    Text("Part #2")
                }
                Section {
                    NavigationLink("Part #3") {
                        ThirdPartView(myAppVM: myAppVM)
                    }
                    
                } header: {
                    Text("Part #3. Work with directories")
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
