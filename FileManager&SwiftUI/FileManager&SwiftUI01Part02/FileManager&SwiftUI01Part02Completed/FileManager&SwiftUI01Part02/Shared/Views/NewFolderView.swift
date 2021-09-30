//
//  NewFolderView.swift
//  FileManager&SwiftUI01Part02 (iOS)
//
//  Created by Petro Onishchuk on 9/23/21.
//

import SwiftUI

struct NewFolderView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                TextField("Folder Name", text: $myAppVM.newFile.fileName)
                    .autocapitalization(.none)
            } header: {
                Text("Naming Folder Section")
            }
            Section {
                Button {
                    myAppVM.printMainDirectory()
                } label: {
                    Text("Print Main Directory")
                }
                Button {
                    myAppVM.createNewDirectory()
                } label: {
                    Text("Create a new Folder")
                }
                .disabled(myAppVM.newFile.fileName.isEmpty)
            } header: {
                Text("Button Section")
            }
            Section {
                TextField("Select Folder Name", text: $myAppVM.selectedFile.fileName)
                    .autocapitalization(.none)
            } header: {
                Text("Select for delete Folder")
            }
            Section {
                if #available(iOS 15.0, *) {
                    Button(role: .destructive) {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete Folder")
                    }
                } else {
                    // Fallback on earlier versions
                    Button {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete Folder")
                    }
                }
            } header: {
                Text("Button Section")
            }
            
        }
        .navigationTitle("Create & Delete Folder")
    }
}

struct NewFolderView_Previews: PreviewProvider {
    static var previews: some View {
        NewFolderView(myAppVM: MyAppViewModel())
    }
}
