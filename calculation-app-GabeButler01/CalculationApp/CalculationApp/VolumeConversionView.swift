//
//  VolumeConversionView.swift
//  CalculationApp
//
//  Created by Gabe Butler on 10/19/24.
//

import SwiftUI

struct VolumeConversionView: View {
    @Binding var selectedUnit: String // unit picked at top of page (from)
    @Binding var convertedUnit: String // unit picked at bottom of page (to)
    @Binding var userInput: Double // value user inputs
    @State private var convertedInput: Double = 1.0 // value the inputed value converts into
    // enum of units
    enum VolumeUnit: String {
        case gallon = "Gallon"
        case quart = "Quart"
        case pint = "Pint"
        case cup = "Cup"
        case fluidOz = "Fluid Oz"
        case tablespoon = "Tablespoon"
        case teaspoon = "Teaspoon"
        case liter = "Liter"
    }
    struct VolumeConverter {
        static func convert(value: Double, from: VolumeUnit, into: VolumeUnit) -> Double {
            let conversionFactors: [VolumeUnit: Double] = [
                .gallon: 1.0,
                .quart: 1.0 / 4,
                .pint: 1.0 / 8,
                .cup: 1.0 / 15.773,
                .fluidOz: 1.0 / 128,
                .tablespoon: 1.0 / 256,
                .teaspoon: 1.0 / 768,
                .liter: 1.0 / 3.785
            ]
            let gallon = value * (conversionFactors[from] ?? 1.0) // always convert to gallons first
            return gallon / (conversionFactors[into] ?? 1.0) // convert to what you actually want
        }
    }

    var body: some View {
            if let fromUnit = VolumeUnit(rawValue: selectedUnit),
               let toUnit = VolumeUnit(rawValue: convertedUnit) {
                // convert input into output
                let convertedOutput = VolumeConverter.convert(value: userInput, from: fromUnit, into: toUnit)
                // display output to 2 decimal places or scientific notation if very large or small
                if convertedOutput == 0 {
                    Text(String(format: "%.2f", convertedOutput))
                } else if 0.01 >= convertedOutput || convertedOutput >= 99999 {
                    Text(String(format: "%.2e", convertedOutput))
                } else {
                    Text(String(format: "%.2f", convertedOutput))
                }}
        }
}
