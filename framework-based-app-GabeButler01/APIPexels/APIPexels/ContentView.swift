//
//  ContentView.swift
//  APIPexels
//
//  Created by Gabe Butler on 12/9/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Search", systemImage: "magnifyingglass") {
                ImageSearchPage()
            }

            Tab("Favorites", systemImage: "star") {
                FavoritesPage()
            }
        }
        .modelContainer(for: FavoriteItem.self, inMemory: false, isAutosaveEnabled: true)
    }
}

#Preview {
    ContentView()
}
