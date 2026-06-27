//
//  ContentView.swift
//  APIPexels
//
//  Created by Gabe Butler on 11/8/24.
//

import SwiftUI

var apiKey: String? {
    Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
}

var baseURL: String? {
    Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String
}

struct ContentView: View {

    @State private var imageSearch = ""
    @State private var fetchedImageURL: String?
    @State private var averageColor: String?

    @State private var debounceWorkItem: DispatchWorkItem?

    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: averageColor ?? "#FFFFFF") // bg color
                    .opacity(0.3)
                    .ignoresSafeArea()
                VStack {
                    if let fetchedImageURL = fetchedImageURL,
                       let url = URL(string: fetchedImageURL) {
                        AsyncImage(url: url) { image in image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .onAppear {
                            if !imageSearch.isEmpty {
                                fetchData()
                            }
                        }
                    }
                }
                .navigationTitle("Search for an image")
                .searchable(text: $imageSearch)
                .onChange(of: imageSearch) { debounceSearch() }
                .padding()
            }
        }
    }

    func debounceSearch() {
        debounceWorkItem?.cancel() // cancel previous
        // new item that calls fetchData after delay
        let workItem = DispatchWorkItem {
            fetchData()
        }
        debounceWorkItem = workItem
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem) // 0.5 second delay
    }

    func fetchData() {
        guard
            let baseURL,
            let apiKey,
            !imageSearch.isEmpty,
            let url = URL(string: "\(baseURL)\(imageSearch)&per_page=1")
        else {
            return
        }

        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("\(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else { return }

            do {
                let reqResponse = try JSONDecoder().decode(StockImage.self, from: data)
                print(reqResponse)

                if let photo = reqResponse.photos.first {
                    DispatchQueue.main.async {
                        fetchedImageURL = photo.src.original // image
                        averageColor = photo.avgColor // bg color
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        .resume()
    }
}

#Preview {
    ContentView()
}

extension Color {
    init(hex: String) {
        let hex = hex.replacingOccurrences(of: "#", with: "") // remove # from hex (API uses # but it isnt needed)
        var rgb: UInt64 = 0xFFFFFF

        // convert hex to rgb
        if hex.count == 6, Scanner(string: hex).scanHexInt64(&rgb) {
            let red = Double((rgb & 0xFF0000) >> 16) / 255.0
            let green = Double((rgb & 0x00FF00) >> 8) / 255.0
            let blue = Double(rgb & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue)
        } else {
            self.init(white: 1.0)
        }
    }
}

// Pexels API struct
struct StockImage: Codable {
    let totalResults: Int
    let page: Int
    let perPage: Int
    let photos: [Photo]
    let nextPage: String

    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case page
        case perPage = "per_page"
        case photos
        case nextPage = "next_page"
    }
}

struct Photo: Codable {
    let id: Int
    let width: Int
    let height: Int
    let url: String
    let photographer: String
    let photographerURL: String
    let photographerID: Int
    let avgColor: String
    let src: Source
    let liked: Bool
    let alt: String

    enum CodingKeys: String, CodingKey {
        case id
        case width
        case height
        case url
        case photographer
        case photographerURL = "photographer_url"
        case photographerID = "photographer_id"
        case avgColor = "avg_color"
        case src
        case liked
        case alt
    }
}

struct Source: Codable {
    let original: String
    let large2x: String
    let large: String
    let medium: String
    let small: String
    let portrait: String
    let landscape: String
    let tiny: String
}
