//
//  HomeApp.swift
//  Home
//
//  Created by Home on 1/7/21.
//

import SwiftUI

@main
struct HomeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
