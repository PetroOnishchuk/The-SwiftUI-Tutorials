//
//  DetailObjectView.swift
//  FileManager&SwiftUI01Part03 (iOS)
//
//  Created by Petro Onishchuk on 10/3/21.
//

import SwiftUI

struct DetailObjectView: View {
    
    @ObservedObject var myAppVM: MyAppViewModel
    @State var currentFile: MyFile
    @State var currentLocation: String
    
    
    var body: some View {
        VStack {
            if currentFile.typeOfFile == "folder" {
                NavigationLink(currentFile.fileName) {
                    MovingFilesView(myAppVM: myAppVM, currentLocation: currentLocation + "/" + currentFile.fileName, currentFolder: currentFile.fileName)
                }
            } else {
                Text(currentFile.fileName)
            }
        }
    }
}

struct DetailObjectView_Previews: PreviewProvider {
    static var previews: some View {
        DetailObjectView(myAppVM: MyAppViewModel(),
                         currentFile: MyFile(fileName: "", fileExtension: "", textForFile: "", image: nil, typeOfFile: ""),
                         currentLocation: "")
    }
}
