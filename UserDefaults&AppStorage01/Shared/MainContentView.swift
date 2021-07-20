//
//  MainContentView.swift
//  MainContentView
//
//  Created by Petro Onishchuk on 7/19/21.
//

import SwiftUI

struct MainContentView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("#01")) {
                    NavigationLink(UserDefaultsSection.state.rawValue) {
                        ContentView01()
                    }
                }
                Section(header: Text("#02")) {
                    NavigationLink(UserDefaultsSection.appStorageSimple.rawValue) {
                        ContentView02()
                    }
                }
                Section(header: Text("#03")) {
                    NavigationLink(UserDefaultsSection.sceneStorageSimple.rawValue) {
                        ContentView03()
                    }
                }
                Section(header: Text("#04")) {
                    NavigationLink(UserDefaultsSection.appStorageAndUD.rawValue) {
                        ContentView04()
                    }
                }
                Section(header: Text("#05")) {
                    NavigationLink(UserDefaultsSection.stateAndCustomObject.rawValue) {
                        ContentView05()
                    }
                }
                Section(header: Text("#06")) {
                    NavigationLink(UserDefaultsSection.appStorageAndCustomObject.rawValue) {
                        ContentView06()
                    }
                }
                Section(header: Text("#07")) {
                    NavigationLink(UserDefaultsSection.appStorageAndCustomObjectAndUD.rawValue) {
                        ContentView07()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("UserDefaults & @AppStorage & @SceneStorage")
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct MainContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
