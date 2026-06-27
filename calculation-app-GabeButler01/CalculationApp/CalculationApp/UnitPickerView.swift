//
//  UnitPickerView.swift
//  CalculationApp
//
//  Created by Gabe Butler on 10/12/24.
//

import SwiftUI

struct UnitPickerView: View {
    @State var units: [String] // import list of units (depending on page)
    @State private var selectedUnit: String // unit selected at top (from)
    @State private var convertedUnit: String // unit selected at bottom (to)
    @State private var userInput: Double // user input value
    init(units: [String]) {
        self.units = units
        selectedUnit = units[0]
        convertedUnit = units[1]
        userInput = 0.0
    }
    var body: some View {
        VStack {
            // based on first unit in unit string, create a title for the page (unit type)
            Group {
                if units[0] == "Pound" {
                    Text("Mass")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                if units[0] == "Inch" {
                    Text("Length")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                if units[0] == "Gallon" {
                    Text("Volume")
                        .font(.title)
                        .fontWeight(.heavy)
                }
                if units[0] == "Millisecond" {
                    Text("Time")
                        .font(.title)
                        .fontWeight(.heavy)
                }
            }
            .padding()
            // input value and unit (from)
            HStack {
                TextField("Value", value: $userInput, format: .number)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title2)
                    .frame(width: 80)
                    .padding(.trailing, 5.0)
                    .bold()

                Text("\(selectedUnit)")
                    .font(.title2)
                    .foregroundColor(Color.mint)
                    .bold()
            }
            // unit selector
            Picker("Select an option", selection: $selectedUnit) {
                ForEach(units, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)
            Text("=")
                .font(.title)
            Picker("Select an option", selection: $convertedUnit) {
                ForEach(units, id: \.self) { item in
                    Text(item)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 100)
            // run conversion code depending on what units being used
            HStack {
                if units[0] == "Pound" {
                    MassConversionView(
                        selectedUnit: $selectedUnit,
                        convertedUnit: $convertedUnit,
                        userInput: $userInput
                    )
                }
                if units[0] == "Inch" {
                    LengthConversionView(
                        selectedUnit: $selectedUnit,
                        convertedUnit: $convertedUnit,
                        userInput: $userInput
                    )
                }
                if units[0] == "Gallon" {
                    VolumeConversionView(
                        selectedUnit: $selectedUnit,
                        convertedUnit: $convertedUnit,
                        userInput: $userInput
                    )
                }
                if units[0] == "Millisecond" {
                    TimeConversionView(
                        selectedUnit: $selectedUnit,
                        convertedUnit: $convertedUnit,
                        userInput: $userInput
                    )
                }
                Text(" \(convertedUnit)")
                    .foregroundColor(Color(hue: 0.001, saturation: 0.808, brightness: 0.982))
            }
            .font(.title2)
            .bold()
            .monospacedDigit()
        }
    }
}

#Preview {
    UnitPickerView(units: ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"])
}
