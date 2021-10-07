//
//  NewFileView.swift
//  FileManager&SwiftUI01Part02 (iOS)
//
//  Created by Petro Onishchuk on 9/25/21.
//

import SwiftUI

struct NewFileView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                TextField("File Name", text: $myAppVM.newFile.fileName)
                TextField("File Extension", text: $myAppVM.newFile.fileExtension)
            } header: {
                Text("Naming File Section")
            }
            .autocapitalization(.none)
            
            Section {
                Button {
                    myAppVM.createNewFile()
                } label: {
                    Text("Create New File")
                }
            } header: {
                Text("Button Section")
            }
            .disabled(myAppVM.isEmpty(myFile: myAppVM.newFile))
            Section {
                TextField("File Name", text: $myAppVM.selectedFile.fileName)
                TextField("File extension", text: $myAppVM.selectedFile.fileExtension)
            } header: {
                Text("Section for Delete File")
            }
            .autocapitalization(.none)
            Section {
                if #available(iOS 15.0, *) {
                    Button(role: .destructive) {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete File")
                    }
                } else {
                    // Fallback on earlier versions
                    Button {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete File")
                    }
                }

                
            } header: {
                Text("Button Section")
            }
            .disabled(myAppVM.isEmpty(myFile: myAppVM.selectedFile))
        }.navigationTitle("Create & Delete New File")
    }
}

struct NewFileView_Previews: PreviewProvider {
    static var previews: some View {
        NewFileView(myAppVM: MyAppViewModel())
    }
}
