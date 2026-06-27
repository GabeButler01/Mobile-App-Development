//
//  FavoriteImageWidget.swift
//  FavoriteImageWidget
//
//  Created by Gabe Butler on 12/12/24.
//

import WidgetKit
import SwiftUI

// SimpleEntry now includes the required date property, even though it's not used
struct SimpleEntry: TimelineEntry {
    let date: Date
    let imageName: String
}

// Provider for fetching a random image name (now pointing to the asset image)
struct Provider: TimelineProvider {

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), imageName: "14")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), imageName: "14")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Using local image from assets
        let imageNames = ["14"]  // Image name in the asset catalog

        // Generate timeline entries (e.g., every 5 minutes)
        for _ in 0..<5 {
            let randomImageName = imageNames.randomElement() ?? imageNames[0]
            let entry = SimpleEntry(date: Date(), imageName: randomImageName)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct FavoriteImageWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geometry in
            // Display image from assets instead of a URL
            Image(entry.imageName)
                .resizable()  // Make the image resizable
                .scaledToFill()  // Scale it to fill the space
                .frame(width: geometry.size.width, height: geometry.size.height)  // Set the image's size
                .clipped()  // Clip the image to the bounds of the widget
        }
        .padding()  // Add padding to ensure the image doesn't touch edges
    }
}

struct FavoriteImageWidget: Widget {
    let kind: String = "FavoriteImageWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FavoriteImageWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)  // Apply background
        }
        .configurationDisplayName("Favorite Image Widget")
        .description("Displays a favorite image from the asset catalog.")
    }
}

#Preview(as: .systemSmall) {
    FavoriteImageWidget()  // Correct widget name used here
} timeline: {
    SimpleEntry(date: Date(), imageName: "14")
}

