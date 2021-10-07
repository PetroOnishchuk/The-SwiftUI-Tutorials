//
//  SecondPartView.swift
//  FileManager&SwiftUI01Part02 (iOS)
//
//  Created by Petro Onishchuk on 9/25/21.
//

import SwiftUI

struct SecondPartView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                NavigationLink("Create New File") {
                    NewFileView(myAppVM: myAppVM)
                }
            } header: {
                Text("Create New File")
            }
            Section {
                NavigationLink("Create new file with text") {
                    NewFileWithTextView(myAppVM: myAppVM)
                }
            } header: {
                Text("Create new file with text")
            }
            Section {
                NavigationLink("Create JSON File") {
                    NewJSONFileView(myAppVM: myAppVM)
                }
            } header: {
                Text("Create JSON File")
            }
            Section {
                NavigationLink("Work With Image") {
                    NewImageView(myAppVM: myAppVM)
                }
                
            } header: {
                Text("Work With Image")
            }
             
        }.navigationTitle("File Manager & SwiftUI Second Part")
    }
}

struct SecondPartView_Previews: PreviewProvider {
    static var previews: some View {
        SecondPartView(myAppVM: MyAppViewModel())
    }
}
