//
//  SingleUserView.swift
//  URLSessionGenericAndDatabaseiOS01
//
//  Created by Petro Onishchuk on 6/2/22.
//

import SwiftUI

struct SingleUserView: View {
    
    let user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("ID: \(user.id)")
                Text("First Name: \(user.firstName.capitalizingFirstLetter())")
                Text("Last Name: \(user.lastName.capitalizingFirstLetter())")
                Text("📧: \(user.email)")
            }
            .font(Font.system(size: 15))
            Spacer()
            AsyncImage(url: URL(string: user.avatar)) {
                imagePhase in
                switch imagePhase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                case .empty:
                    Text(user.avatar)
                        .emojiAvatarStyle()
                case .failure(_):
                    Text(user.avatar)
                        .emojiAvatarStyle()
                @unknown default:
                    Text(user.avatar)
                        .emojiAvatarStyle()
                }
            }
        }
    }
}

struct SingleUserView_Previews: PreviewProvider {
    static var previews: some View {
        SingleUserView(user: User(id: 0, firstName: "First", lastName: "Last", email: "", avatar: ""))
    }
}
