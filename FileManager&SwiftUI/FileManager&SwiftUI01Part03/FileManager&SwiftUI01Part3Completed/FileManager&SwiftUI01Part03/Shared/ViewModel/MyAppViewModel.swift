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
    @Published var arrayOfFiles: [MyFile]
    @Published var originPath: String
    @Published var destinationPath: String
    
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
    
    //MARK: Take contents of Directory
    func takeContentsOfDirectory() -> [String] {
        return myAppFileManager.takeContentsOfDirectory(addPath: additionPath)
    }
    
    //MARK: take Attributes
    func takeAttributes(name: String) -> FileAttributeType? {
        return myAppFileManager.takeAttributes(addPath: additionPath, name: name)
    }
    
    //MARK: Take array of Items with Type
    func takeArrayOfItemsWithType() {
        let arrayOfItems = takeContentsOfDirectory()
        var internalArrayOfFiles = [MyFile]()
        
        for item in arrayOfItems {
            if takeAttributes(name: item) == FileAttributeType.typeDirectory {
                internalArrayOfFiles.append(MyFile(fileName: item, fileExtension: "", textForFile: "", image: nil, typeOfFile: "folder"))
            } else {
                internalArrayOfFiles.append(MyFile(fileName: item, fileExtension: "", textForFile: "", image: nil, typeOfFile: "file"))
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.arrayOfFiles = internalArrayOfFiles
        }
    }
    
    
    //MARK: Set Origin Path
    func setOriginPath(currentPath: String) {
        originPath = currentPath
    }
    
    //MARK: Set Destination Path
    func setDestinationPath(currentPath: String) {
        destinationPath = currentPath
    }
    
    //MARK: Move Content
    func moveContentOnMyApp() {
        myAppFileManager.moveContentMyApp(atPath: originPath, toPath: destinationPath, myFile: selectedFile)
        
        originPath = ""
        destinationPath = ""
        
        takeArrayOfItemsWithType()
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
    
    
    init(newFile: MyFile, selectedFile: MyFile, additionPath: String, newLaptop: Laptop, allLaptops: [Laptop], arrayOfFiles: [MyFile], originPath: String, destinationPath: String ) {
        self.newFile = newFile
        self.selectedFile = selectedFile
        self.additionPath = additionPath
        self.newLaptop = newLaptop
        self.allLaptops = allLaptops
        self.arrayOfFiles = arrayOfFiles
        self.originPath = originPath
        self.destinationPath = destinationPath
    }
    
    init() {
        newFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
        selectedFile = MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: "")
        additionPath = ""
        newLaptop = Laptop(name: "", releaseDate: "", color: "")
        allLaptops = [Laptop]()
        arrayOfFiles = [MyFile]()
        originPath = ""
        destinationPath = ""
    }
    
    
}
