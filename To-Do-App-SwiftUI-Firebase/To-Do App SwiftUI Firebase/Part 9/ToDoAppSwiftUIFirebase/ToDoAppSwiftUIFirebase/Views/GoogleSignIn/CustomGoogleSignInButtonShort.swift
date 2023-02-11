//
//  SecCustomGoogle.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/10/23.
//

import SwiftUI

struct CustomGoogleSignInButtonShort: View {
    @EnvironmentObject var myAppVM: MyAppViewModel
    @State var blurText: CGFloat = 0
    var body: some View {
        HStack {
            Image("google3")
              .resizable()
              .scaledToFill()
              .frame(width: 16, height: 16, alignment: .center)
            Text("Sign in with Google")
                  .font(Font.system(size: 15))
                  .blur(radius: blurText)
              
          }.gesture(DragGesture(minimumDistance: 0.0)
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

struct SecCustomGoogle_Previews: PreviewProvider {
    static var previews: some View {
        CustomGoogleSignInButtonShort()
    }
}
