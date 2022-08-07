//
//  MainContentView.swift
//  SwiftUIandAmazonSNSPush
//
//  Created by Petro Onishchuk on 8/7/22.
//

import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var notificationAppVM: NotificationAppVM
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(notificationAppVM.allMessages, id: \.self) {
                        message in
                        VStack(alignment: .leading) {
                            Text("Title: \(message.title)")
                            Text("Info: \(message.description)")
                            Text("Date: \(notificationAppVM.convertDate(date: message.massageDate))")
                        }
                    }
                } header: {
                    Text("Messages List Section")
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(role: .destructive) {
                        notificationAppVM.cleanMessageList()
                    } label: {
                        Text("Clean List")
                    }

                }
               
            }
            .navigationTitle("Notification from ASNS")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                notificationAppVM.setupNotifications()
            }
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
