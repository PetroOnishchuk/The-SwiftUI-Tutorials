//
//  ThirdPartView.swift
//  FileManager&SwiftUI01Part03 (iOS)
//
//  Created by Petro Onishchuk on 10/1/21.
//

import SwiftUI

struct ThirdPartView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                NavigationLink("Basic List of Files") {
                    BasicListOfFilesView(myAppVM: myAppVM)
                }
                
            } header: {
                Text("Basic List of Files")
            }
            
            Section {
                NavigationLink("Moving Content") {
                  MovingFilesView(myAppVM: myAppVM)
                }
                
            } header: {
                Text("Moving Content")
            }
        }
    }
}

struct ThirdPartView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartView(myAppVM: MyAppViewModel())
    }
}
