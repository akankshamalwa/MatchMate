//
//  MatchMateApp.swift
//  MatchMate
//
//  Created by Akanksha Dipak Bothe on 19/03/25.
//

import SwiftUI

@main
struct MatchMateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
