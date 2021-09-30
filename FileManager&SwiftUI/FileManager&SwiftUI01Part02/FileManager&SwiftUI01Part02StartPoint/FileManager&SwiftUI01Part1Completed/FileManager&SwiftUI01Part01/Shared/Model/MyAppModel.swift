//
//  MyAppModel.swift
//  FileManager&SwiftUI01Part01 (iOS)
//
//  Created by Petro Onishchuk on 9/17/21.
//

import SwiftUI

struct MyFile {
    var id: UUID = UUID()
    var fileName: String
    var fileExtension: String
    var textForFile: String
    var additionPath: String?
    var image: UIImage?
    var typeOfFile: String
    var imageExtension: String {
        guard image != nil, let imageExt = image?.imageExtension else {
            return "Don't find image extension"
        }
        return imageExt
    }
    
    
    init(fileName: String, fileExtension: String, textForFile: String, image: UIImage?, typeOfFile: String ) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.textForFile = textForFile
        self.image = image
        self.typeOfFile = typeOfFile 
    }
    
}


extension UIImage {
    var typeIdentifier: String? {
        cgImage?.utType as String?
    }
    var imageExtension: String? {
        let imageExtension =  typeIdentifier?.components(separatedBy: ".")
        return imageExtension?[1]
    }
}


