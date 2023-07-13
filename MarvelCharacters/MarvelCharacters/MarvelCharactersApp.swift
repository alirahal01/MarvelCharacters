//
//  MarvelCharactersApp.swift
//  MarvelCharacters
//
//  Created by ali rahal on 13/07/2023.
//

import SwiftUI

@main
struct MarvelCharactersApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
