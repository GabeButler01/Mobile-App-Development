//
//  FullSizeImageView.swift
//  APIPexels
//
//  Created by Gabe Butler on 12/9/24.
//

import SwiftUI
import SwiftData

struct FullSizeImageView: View {
    let imageURL: URL
    @Environment(\.modelContext) private var modelContext
    @Query private var favoriteImages: [FavoriteItem]

    var body: some View {
        VStack {
            // Display full screen image
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }

            // favorite button
            Button {
                toggleFavorite(url: imageURL.absoluteString)
            } label: {
                Image(systemName: "star.fill")
                    .foregroundColor(isFavorite(imageURL.absoluteString) ? .yellow : .gray)
                    .font(.title)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // Check if the image is in favorites
    func isFavorite(_ url: String) -> Bool {
        favoriteImages.contains { $0.url == url }
    }

    // Toggle favorite state
    func toggleFavorite(url: String) {
        if let existingImage = favoriteImages.first(where: { $0.url == url }) {
            // Remove from favorites
            modelContext.delete(existingImage)
        } else {
            // Add to favorites
            let newFavorite = FavoriteItem(url: url, favorite: true)
            modelContext.insert(newFavorite)
        }
    }
}
