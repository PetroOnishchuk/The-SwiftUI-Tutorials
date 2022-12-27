//
//  MainContentView.swift
//  SwiftUIandFirebaseAndPushNotifications01
//
//  Created by Petro Onishchuk on 8/25/22.
//

import SwiftUI

struct MainContentView: View {
    
    @EnvironmentObject var myAppVM: MyAppViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    // V.1 ForEach with Enumerated
                    ForEach(myAppVM.allMessages.indices, id: \.self) { index in
                        HStack {
                            Text("\(index + 1)")
                            VStack(alignment: .leading) {
                                Text("Title: \(myAppVM.allMessages[index].title)")
                                Text("Body: \(myAppVM.allMessages[index].body)")
                                    .customFontSize(with: 10)
                                Text("Date: \(myAppVM.convertData(date: myAppVM.allMessages[index].messagesDate))")
                                    .customFontSize(with: 10)
                            }
                            Spacer()
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.green)
                        }
                    }
                    // V.2 ForEach With enumerated
//                    ForEach(Array(zip(myAppVM.allMessages.indices, myAppVM.allMessages)), id: \.0) { index, message in
//                        HStack {
//                            Text("\(index + 1)")
//                            VStack(alignment: .leading) {
//                                Text("Title: \(message.title)")
//                                Text("Body: \(message.body)")
//                                    .customFontSize(with: 10)
//                                Text("Date: \(myAppVM.convertData(date: message.messagesDate))")
//                                    .customFontSize(with: 10)
//                            }
//                        }
//                    }
                    
                    
                // V.3 For Each without enumerated
//                    ForEach(myAppVM.allMessages, id: \.id) { message in
//                        VStack(alignment: .leading) {
//                            Text("Title: \(message.title)")
//                            Text("Body: \(message.body)")
//                                .customFontSize(with: 10)
//                            Text("Date: \(myAppVM.convertData(date: message.messagesDate))")
//                                .customFontSize(with: 10)
//                        }
//                    }
                } header: {
                    Text("Message List Section")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        myAppVM.cleanAllMessageList()
                    } label: {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                    }

                }
            }
            .navigationTitle("SwiftUI & Firebase")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                myAppVM.setupNotifications()
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
