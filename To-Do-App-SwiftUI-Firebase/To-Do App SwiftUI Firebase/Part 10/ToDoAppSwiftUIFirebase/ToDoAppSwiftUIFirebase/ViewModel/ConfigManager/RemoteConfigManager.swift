//
//  RemoteConfigManager.swift
//  ToDoAppSwiftUIFirebase
//
//  Created by Petro Onishchuk on 2/15/23.
//

import SwiftUI
import FirebaseRemoteConfig
import FirebaseRemoteConfigSwift
import Firebase

struct RemoteConfigManager {
    private static var remoteConfig: RemoteConfig = {
        var remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        return remoteConfig
    }()
    
    //This method you run inside AppDelegate.swift file
    static func configure(exprationDuration: TimeInterval = 1.0) {
        remoteConfig.fetch(withExpirationDuration: exprationDuration) { status, error in
            switch status {
            case .success:
                print("Config Fetched!")
                self.remoteConfig.activate()
            case .failure:
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
                
            case .noFetchYet:
                print("Config not fetched yet")
            case .throttled:
                print("Config throttled")
            @unknown default:
                print("Config not fetched")
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
            
            print("Value: Remote")
            
        }
    }
    // This is old version of fetch value from Config Remote
    // New version I use in TaskCell
    // Example below
    // @RemoteConfigProperty(key: "checkmark", fallback: "checkmark.seal") var checkmark: String
    static func value(forKey key: String) -> String {
        return remoteConfig.configValue(forKey: key).stringValue!
    }
}
