//
//  MyAppViewModel.swift
//  FileManager&SwiftUI01Part01 (iOS)
//
//  Created by Petro Onishchuk on 9/18/21.
//

import SwiftUI

class MyAppViewModel: ObservableObject {
    @Published var newFile: MyFile
    @Published var selectedFile: MyFile
    @Published var additionPath: String
    
    
    let myAppFileManager = MyAppFileManager()
    
    //MARK: Print Main Directory
    func printMainDirectory() {
        myAppFileManager.printMainDirectory(addPath: additionPath, myFile: newFile)
    }
    
    //MARK: Create New Directory
    func createNewDirectory() {
        myAppFileManager.createNewDirectory(addPath: additionPath, myFile: newFile)
        cleanNewFile()
    }
    
    //MARK: Delete Item in Directory
    func deleteItemInDirectory() {
        myAppFileManager.deleteItemInDirectory(addPath: additionPath, myFile: selectedFile)
        cleanSelectedFile()
    }
    
    //MARK: Clean New File
    func cleanNewFile() {
        newFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
    }
    
    //MARK: Clean Selected File
    func cleanSelectedFile() {
        selectedFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
    }
    
    
    
    init(newFile: MyFile, selectedFile: MyFile, additionPath: String) {
        self.newFile = newFile
        self.selectedFile = selectedFile
        self.additionPath = additionPath
    }
    
    init() {
        newFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
        selectedFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
        additionPath = ""
    }
    
    
}
