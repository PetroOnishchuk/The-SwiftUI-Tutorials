//
//  NewFileWithTextView.swift
//  FileManager&SwiftUI01Part02 (iOS)
//
//  Created by Petro Onishchuk on 9/25/21.
//

import SwiftUI

struct NewFileWithTextView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                TextEditor(text: $myAppVM.newFile.textForFile)
                    .frame(minHeight: 200)
            } header: {
                Text("Text Editor Section")
            }
            Section {
                TextField("File Name", text: $myAppVM.newFile.fileName)
                TextField("File Extension", text: $myAppVM.newFile.fileExtension)
                
            } header: {
                Text("Section for Naming File")
            }
            .autocapitalization(.none)
            Section {
                Button("Save File With Text") {
                    myAppVM.createNewFileWithText()
                }
                Button("Take File with Text") {
                    myAppVM.takeFileWithText()
                }
                
            } header: {
                Text("Button Section")
            }
            .disabled(myAppVM.isEmpty(myFile: myAppVM.newFile))
            
            Section {
                TextField("File Name", text: $myAppVM.selectedFile.fileName)
                TextField("File Extension", text: $myAppVM.selectedFile.fileExtension)
            } header: {
                Text("Section for delete file")
            }
            .autocapitalization(.none)
            Section {
                if #available(iOS 15.0, *) {
                    Button(role: .destructive) {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete File with text")
                    }
                } else {
                    // Fallback on earlier versions
                    Button {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete File with text")
                    }
                }

            } header: {
                Text("Button Section")
            }
            .disabled(myAppVM.isEmpty(myFile: myAppVM.selectedFile))
            
        }.navigationTitle("Save and Return File With Text")
    }
}

struct NewFileWithTextView_Previews: PreviewProvider {
    static var previews: some View {
        NewFileWithTextView(myAppVM: MyAppViewModel())
    }
}
