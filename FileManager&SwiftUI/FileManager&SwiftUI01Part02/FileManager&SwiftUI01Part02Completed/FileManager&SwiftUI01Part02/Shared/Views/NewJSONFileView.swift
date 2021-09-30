//
//  NewJSONFileView.swift
//  FileManager&SwiftUI01Part02
//
//  Created by Petro Onishchuk on 9/25/21.
//

import SwiftUI

struct NewJSONFileView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    var body: some View {
        List {
            Section {
                List {
                    ForEach(myAppVM.allLaptops, id: \.id) {
                        laptop in
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Laptop: \(laptop.name)")
                            Text("Release date: \(laptop.releaseDate)")
                            Text("Color: \(laptop.color)")
                        }
                        .padding(.bottom, 8)
                    }
                }
                .listStyle(.plain)
                .frame(height: 200)
                
            } header: {
                Text("Section for list of Laptop")
            }
            Section {
                TextField("Enter name for laptop", text: $myAppVM.newLaptop.name)
                TextField("Enter release date", text: $myAppVM.newLaptop.releaseDate)
                TextField("Enter color For Laptop", text:  $myAppVM.newLaptop.color)
                
            } header: {
                Text("Section for naming Laptop")
            }
            Section {
                TextField("File Name", text: $myAppVM.newFile.fileName)
                TextField("File extension", text: $myAppVM.newFile.fileExtension)
            } header: {
                Text("Section for naming File")
            }
            .autocapitalization(.none)
            
            Section {
                Button("Save new Laptop") {
                    myAppVM.allLaptops.append(myAppVM.newLaptop)
                    myAppVM.createEmptyNewLaptop()
                }
                .disabled(myAppVM.isEmptyNewLaptop())
                
                Button("Saved Laptops List as JSON File") {
                    myAppVM.saveJSONObject()
                }
                .disabled(myAppVM.isEmpty(myFile: myAppVM.newFile))
                Button("Take back JSON File") {
                    myAppVM.takeBackJSONObject()
                }
                .disabled(myAppVM.isEmpty(myFile: myAppVM.newFile))
            } header: {
                Text("Button Section")
            }
            
            Section {
                TextField("File Name", text: $myAppVM.selectedFile.fileName)
                TextField("File Extension", text: $myAppVM.selectedFile.fileExtension)
            } header: {
                Text("Section For Delete file")
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
            
            
        }
        .navigationTitle("Work with JSON Object")
    }
}

struct NewJSONFileView_Previews: PreviewProvider {
    static var previews: some View {
        NewJSONFileView(myAppVM: MyAppViewModel())
    }
}
