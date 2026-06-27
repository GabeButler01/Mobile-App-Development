//
//  ContentView.swift
//  CalculationApp
//
//  Created by Gabe Butler on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    // list of units (seperated by type)
    @State private var massUnits = ["Pound", "Ounce", "Gram", "Kilogram", "US ton", "Metric ton"]
    @State private var lengthUnits = ["Inch", "Foot", "Yard", "Mile", "Millimeter", "Centimeter", "Meter", "Kilometer"]
    @State private var volumeUnits = ["Gallon", "Quart", "Pint", "Cup", "Fluid Oz", "Tablespoon", "Teaspoon", "Liter"]
    @State private var timeUnits = ["Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year"]
    // tab view, each page has conversion for a different unit type
    var body: some View {
        TabView {
            view1
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            UnitPickerView(units: massUnits)
                .tabItem {
                    Label("Mass", systemImage: "scalemass")
                }
            UnitPickerView(units: lengthUnits)
                .tabItem {
                    Label("Length", systemImage: "ruler")
                }
            UnitPickerView(units: volumeUnits)
                .tabItem {
                    Label("Volume", systemImage: "mug")
                }
            UnitPickerView(units: timeUnits)
                .tabItem {
                    Label("Time", systemImage: "hourglass")
                }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

// welcome page
var view1: some View {
    VStack {
        Text("Unit Conversion")
            .font(.largeTitle)
            .fontWeight(.heavy)

        Group {
            Text("Swipe to the page with the appropraite units for your converting inquiries.")
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20.0)
                .padding(.vertical, 5.0)
        }
        .frame(
            maxWidth: /*@START_MENU_TOKEN@*//*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*//*@END_MENU_TOKEN@*/
        )
    }
}

#Preview {
    ContentView()
}
