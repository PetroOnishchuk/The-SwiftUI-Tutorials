//
//  ProjectImageViewModel.swift
//  ContextMenu&SwiftUI01
//
//  Created by Petro Onishchuk on 12/24/21.
//

import SwiftUI



class ProjectImageViewModel: ObservableObject {
    @Published var allImages: [ProjectImage] = projectImageData
    
    func setColor(_ color: Color, for image: ProjectImage) {
        guard let index = allImages.firstIndex(where: { imageFromArray in
            imageFromArray.id == image.id
        }) else { return }
        
        withAnimation(.linear(duration: 3.0)) {
            allImages[index].color = color
        }
    }
}


