//
//  FavoritesPage.swift
//  APIPexels
//
//  Created by Gabe Butler on 12/9/24.
//

import SwiftUI
import SwiftData

struct FavoritesPage: View {
    @Environment(\.modelContext) private var modelContext

    @Query private var favoriteImages: [FavoriteItem]

    var body: some View {
        NavigationStack {
            VStack {
                if favoriteImages.isEmpty {
                    Text("No favorites yet.")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ScrollView {
                        GalleryView()
                            .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Favorites")
        .padding()
    }
}

#Preview {
    FavoritesPage()
}
