//
//  BasicListOfFilesView.swift
//  FileManager&SwiftUI01Part03 (iOS)
//
//  Created by Petro Onishchuk on 10/1/21.
//

import SwiftUI

struct BasicListOfFilesView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    
    var body: some View {
        List {
            Section {
                List {
                    ForEach(myAppVM.arrayOfFiles, id: \.id) {
                        item in
                        HStack {
                            Text("Item Name: \(item.fileName)")
                            Spacer()
                            Text("Item type: \(item.typeOfFile)")
                        }
                    }
                }
                .frame(height: 300)
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
                
            } header: {
                Text("Items inside Folder Section")
            }
            Section {
                TextField("Enter name of Folder", text: $myAppVM.newFile.fileName)
            } header: {
                Text("Text Field Section")
            }
            Section {
                Button("Create a new Folder") {
                    myAppVM.createNewDirectory()
                }
                Button("Take Contents") {
                    myAppVM.takeArrayOfItemsWithType()
                }
            } header: {
                Text("Button Section")
            }
            
        }.navigationTitle(Text("Basic list of Files"))
    }
}

struct BasicListOfFilesView_Previews: PreviewProvider {
    static var previews: some View {
        BasicListOfFilesView(myAppVM: MyAppViewModel())
    }
}
