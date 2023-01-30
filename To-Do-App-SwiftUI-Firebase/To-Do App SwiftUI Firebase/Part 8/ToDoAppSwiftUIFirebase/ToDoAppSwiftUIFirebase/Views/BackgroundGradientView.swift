//
//  BackgroundGradientView.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 1/26/23.
//

import SwiftUI

struct BackgroundGradientView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color.gray.opacity(0.4), Color.gray]), startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
    }
}
