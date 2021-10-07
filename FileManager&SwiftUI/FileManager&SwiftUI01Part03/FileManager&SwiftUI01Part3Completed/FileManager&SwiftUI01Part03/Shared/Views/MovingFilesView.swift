//
//  MovingFilesView.swift
//  FileManager&SwiftUI01Part03
//
//  Created by Petro Onishchuk on 10/3/21.
//

import SwiftUI

struct MovingFilesView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    
    @State var currentLocation = ""
    @State var isShowSheet: Bool = false
    @State var currentFolder: String = "Main Folder"
    
    
    var body: some View {
        List {
            Section {
                List {
                    ForEach(myAppVM.arrayOfFiles, id: \.id) {
                        folderItem in
                        if #available(iOS 15.0, *) {
                            DetailObjectView(myAppVM: myAppVM, currentFile: folderItem, currentLocation: currentLocation)
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        myAppVM.selectedFile = folderItem
                                        myAppVM.deleteItemInDirectory()
                                        myAppVM.takeArrayOfItemsWithType()
                                    } label: {
                                        Label("", systemImage: "trash")
                                    }

                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        myAppVM.setOriginPath(currentPath: currentLocation + "/" + folderItem.fileName)
                                        myAppVM.selectedFile = folderItem
                                    } label: {
                                        Label("Cut", systemImage: "scissors")
                                    }
                                }
                            
                        } else {
                            // Fallback on earlier versions
                            Text("Update Your iOS")
                        }
                    }
                    
                }
                .frame(height: 300)
                .listStyle(.plain)
                .listRowInsets(EdgeInsets())
                
            } header: {
                 Text("Items inside Folder")
            }
            Section {
                TextField("Enter name for Folder", text: $myAppVM.newFile.fileName)
            } header: {
                Text("Naming new Folder Section")
            }
            Section {
                Button("Create New Folder") {
                    myAppVM.createNewDirectory()
                    myAppVM.takeArrayOfItemsWithType()
                }
                .disabled(myAppVM.newFile.fileName.isEmpty)
                Button("Take Content") {
                    myAppVM.takeArrayOfItemsWithType()
                }
                Button("Cut Folder") {
                    myAppVM.setOriginPath(currentPath: currentLocation)
                    myAppVM.selectedFile.fileName = currentFolder
                }
                Button("Past Object") {
                    myAppVM.setDestinationPath(currentPath: currentLocation)
                    myAppVM.moveContentOnMyApp()
                }
            } header: {
                Text("Button Section")
            }
        }
        .listStyle(GroupedListStyle())
        .navigationTitle(Text(currentFolder))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isShowSheet) {
            myAppVM.takeArrayOfItemsWithType()
        } content: {
            NavigationView {
                SecondPartView(myAppVM: myAppVM)
            }
        }
        .onAppear {
            myAppVM.additionPath = currentLocation
            myAppVM.takeArrayOfItemsWithType()
        }

    }
}

struct MovingFilesView_Previews: PreviewProvider {
    static var previews: some View {
        MovingFilesView(myAppVM: MyAppViewModel())
    }
}
