//
//  APIPexelsApp.swift
//  APIPexels
//
//  Created by Gabe Butler on 11/8/24.
//

import SwiftUI
import SwiftData

@main
struct APIPexelsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(
            for: FavoriteItem.self,
            inMemory: false,
            isAutosaveEnabled: true
        )
    }
}
