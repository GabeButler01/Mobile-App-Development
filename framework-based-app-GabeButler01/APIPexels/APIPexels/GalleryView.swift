//
//  GalleryView.swift
//  APIPexels
//
//  Created by Gabe Butler on 12/9/24.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    @Query private var favoriteImages: [FavoriteItem]

    let columns = [
        GridItem(.adaptive(minimum: 150)) // Display images in grid
    ]

    let thumbnailSize: CGFloat = 150

    var body: some View {
        // thumbnail view of images (lazyvgrid that grows as you favorite more images)
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(favoriteImages, id: \.id) { favoriteItem in
                if let url = URL(string: favoriteItem.url) {
                    NavigationLink(destination: FullSizeImageView(imageURL: url)) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: thumbnailSize, height: thumbnailSize)
                                .cornerRadius(8)
                                .shadow(radius: 4)
                        } placeholder: {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(width: 50, height: 50)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GalleryView()
}
