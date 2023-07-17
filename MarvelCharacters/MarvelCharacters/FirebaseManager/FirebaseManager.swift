//
//  FirebaseManager.swift
//  MarvelCharacters
//
//  Created by ali rahal on 17/07/2023.
//

import Foundation

import Firebase
import FirebaseCrashlytics
import FirebaseRemoteConfig

class FirebaseManager {
    static let shared = FirebaseManager()

    init() {
        FirebaseApp.configure()
        configureFirebaseCrashlytics()
        configureFirebaseRemoteConfig()
    }

    func configureFirebaseCrashlytics() {
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(true)
        // Additional Crashlytics configuration if needed
    }

    func configureFirebaseRemoteConfig() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 3600

        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")

        // Fetch remote config values
        remoteConfig.fetch { _, error in
            if let error = error {
                print("Error fetching remote config: \(error)")
            } else {
                remoteConfig.activate { _, _ in
                    // Remote config successfully fetched and activated
                    // Use the fetched values as needed
                }
            }
        }
    }
}
