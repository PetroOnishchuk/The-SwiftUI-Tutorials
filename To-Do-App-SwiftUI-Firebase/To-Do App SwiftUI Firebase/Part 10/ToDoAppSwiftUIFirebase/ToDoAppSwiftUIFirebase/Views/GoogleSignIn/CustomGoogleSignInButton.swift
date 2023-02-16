//
//  CustomGoogleSignInButton.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/9/23.
//

import SwiftUI

struct CustomGoogleSignInButton: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var blurText: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 0) {
            if colorScheme == .dark {
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 48)
                    .border(colorScheme ==  ColorScheme.light ? Color.blue : Color.white)
            } else {
                Image("google")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 48)
            }
            Text("Sign in  ")
                .font(Font.system(size: 14))
                .fontWeight(.bold)
                .foregroundColor(colorScheme == ColorScheme.light ? Color.white : Color.black)
                .blur(radius: blurText)
                .padding(.leading, 8)
            Spacer()
        }
        .frame(maxWidth: 355)
        .frame(height: 42)
        .padding(0)
            .background(colorScheme == ColorScheme.light ? Color("googleColor") : Color.white)
            .border(colorScheme ==  ColorScheme.light ? Color("googleColor") : Color.white)
            .cornerRadius(2)
            .lineSpacing(0)
            .gesture(DragGesture(minimumDistance: 0.0)
                           .onChanged { _ in
                               blurText = 2
                               print("Pressing started and/or ongoing")
                       }
                       .onEnded { _ in
                         blurText = 0
                           print("Pressing ended")
                           myAppVM.googleSignIn()
                       })
    }
}

//struct CustomGoogleSignInButton_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomGoogleSignInButton( blurText: 1.0)
//    }
//}
