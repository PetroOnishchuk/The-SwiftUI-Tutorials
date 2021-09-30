//
//  MyAppViewModel.swift
//  FileManager&SwiftUI01Part02 (iOS)
//
//  Created by Petro Onishchuk on 9/23/21.
//

import SwiftUI

class MyAppViewModel: ObservableObject {
    @Published var newFile: MyFile
    @Published var selectedFile: MyFile
    @Published var additionPath: String
    @Published var newLaptop: Laptop
    @Published var allLaptops: [Laptop]
    
    
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
    
    //MARK: Create New File
    func createNewFile() {
        myAppFileManager.createNewFile(addPath: additionPath, myFile: newFile)
        cleanNewFile()
    }
    
    
    //MARK: Delete Item in Directory
    func deleteItemInDirectory() {
        myAppFileManager.deleteItemInDirectory(addPath: additionPath, myFile: selectedFile)
        cleanSelectedFile()
        cleanNewFile()
    }
    
    //MARK: Is empty MyFile
    func isEmpty(myFile: MyFile) -> Bool {
        if myFile.fileName.isEmpty || myFile.fileExtension.isEmpty {
            return true
        } else {
            return false
        }
    }
    
    //MARK: Is Empty NewLaptop
    func isEmptyNewLaptop() -> Bool {
        if newLaptop.name.isEmpty || newLaptop.releaseDate.isEmpty || newLaptop.color.isEmpty {
            return true
        } else {
            return false
        }
    }
    //MARK: Clean New File
    func cleanNewFile() {
        newFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
    }
    
    //MARK: Create new File with text
    func createNewFileWithText() {
        myAppFileManager.createNewFileWithText(addPath: additionPath, myFile: newFile)
        cleanNewFile()
    }
    
    //MARK: Take file with Text
    func takeFileWithText() {
        newFile.textForFile = myAppFileManager.takeFileWithText(addPath: additionPath, myFile: newFile)
    }
    
    //MARK: saveJSONObject
    func saveJSONObject() {
        myAppFileManager.saveJSONObject(addPath: additionPath, myFile: newFile, appContent: allLaptops)
        cleanNewFile()
        createEmptyAllLaptops()
    }
    
    //MARK: Take back JSON Object
    func takeBackJSONObject() {
        allLaptops = myAppFileManager.takeBackJSONObject(addPath: additionPath, myFile: newFile)
    }
    
    //MARK: Save Image
    func saveImage() {
        myAppFileManager.saveImage(addPath: additionPath, myFile: newFile)
        cleanNewFile()
    }
    
    //MARK: Take Back Image
    func takeBackSavedImage() {
        let newImage = myAppFileManager.takeBackImage(addPath: additionPath, myFile: newFile)
        DispatchQueue.main.async {[weak self] in
            self?.newFile.image = newImage
            
        }
    }
    
    //MARK: Take Image from Project
    func takeImageFormProject() {
        guard let image = UIImage(named: newFile.fileName) else {
            return
        }
        DispatchQueue.main.async {[weak self] in
            self?.newFile.image = image
            
        }
    }
    
    //MARK: Clean Selected File
    func cleanSelectedFile() {
        selectedFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
    }
    
    //MARK: Create empty newLaptop
    func createEmptyNewLaptop() {
        newLaptop = Laptop(name: "", releaseDate: "", color: "")
    }
    
    //MARK: Create empty allLaptops
    func createEmptyAllLaptops() {
        allLaptops = [Laptop]()
    }
    
    
    init(newFile: MyFile, selectedFile: MyFile, additionPath: String, newLaptop: Laptop, allLaptops: [Laptop]) {
        self.newFile = newFile
        self.selectedFile = selectedFile
        self.additionPath = additionPath
        self.newLaptop = newLaptop
        self.allLaptops = allLaptops
    }
    
    init() {
        newFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
        selectedFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
        additionPath = ""
        newLaptop = Laptop(name: "", releaseDate: "", color: "")
        allLaptops = [Laptop]()
    }
    
    
}
