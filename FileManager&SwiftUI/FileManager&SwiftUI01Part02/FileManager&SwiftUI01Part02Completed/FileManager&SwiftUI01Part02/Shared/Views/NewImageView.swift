//
//  NewImageView.swift
//  FileManager&SwiftUI01Part02 (iOS)
//
//  Created by Petro Onishchuk on 9/25/21.
//

import SwiftUI

struct NewImageView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                HStack {
                    Spacer()
                    if myAppVM.newFile.image != nil {
                        Image(uiImage: myAppVM.newFile.image!)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)
                    } else {
                        Text("Don't have image YET")
                    }
                    Spacer()
                }
            } header: {
                Text("Image Section")
            }
            Section {
                TextField("File Name", text: $myAppVM.newFile.fileName)
                TextField("File Extension", text: $myAppVM.newFile.fileExtension)
            } header: {
                Text("Naming file Section")
            }
            .autocapitalization(.none)
            
            Section {
                Button("Take Image From Project") {
                    myAppVM.takeImageFormProject()
                }
                .disabled(myAppVM.newFile.fileName.isEmpty)
                Button("Save Image in Folder") {
                    myAppVM.saveImage()
                }
                .disabled(myAppVM.isEmpty(myFile: myAppVM.newFile))
                Button("Take saving image from Folder") {
                    myAppVM.takeBackSavedImage()
                }
                .disabled(myAppVM.isEmpty(myFile: myAppVM.newFile))
            } header: {
                Text("Button Section")
            }
            Section {
                TextField("File Name", text: $myAppVM.selectedFile.fileName)
                TextField("File Extension", text: $myAppVM.selectedFile.fileExtension)
            } header: {
                Text("Section for Delete File")
            }
            .autocapitalization(.none)
            Section {
                if #available(iOS 15.0, *) {
                    Button(role: .destructive) {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete Image")
                    }
                } else {
                    // Fallback on earlier versions
                    Button {
                        myAppVM.deleteItemInDirectory()
                    } label: {
                        Text("Delete Image")
                    }
                }
            } header: {
                Text("Button Section")
            }
            .disabled(myAppVM.isEmpty(myFile: myAppVM.selectedFile))
            .onChange(of: myAppVM.newFile.image) { _ in
                DispatchQueue.main.async {
                    myAppVM.newFile.fileExtension = myAppVM.newFile.imageExtension
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Work with Image")
    }
}

struct NewImageView_Previews: PreviewProvider {
    static var previews: some View {
        NewImageView(myAppVM: MyAppViewModel())
    }
}
