//
//  GMAGApp.swift
//  GMAG
//
//  Created by Abdon Jesus Baybay on 10/23/23.
//

import SwiftUI

@main
struct GMAGApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
