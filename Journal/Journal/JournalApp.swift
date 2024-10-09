//
//  JournalApp.swift
//  Journal
//
//  Created by Jabir Chowdhury on 10/8/24.
//

import SwiftUI

@main
struct JournalApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
