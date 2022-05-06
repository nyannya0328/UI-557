//
//  UI_557App.swift
//  UI-557
//
//  Created by nyannyan0328 on 2022/05/06.
//

import SwiftUI

@main
struct UI_557App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
