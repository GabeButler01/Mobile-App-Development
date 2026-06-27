//
//  MassConversionView.swift
//  CalculationApp
//
//  Created by Gabe Butler on 10/13/24.
//

import SwiftUI

struct MassConversionView: View {
    @Binding var selectedUnit: String // unit picked at top of page (from)
    @Binding var convertedUnit: String // unit picked at bottom of page (to)
    @Binding var userInput: Double // value user inputs
    @State private var convertedInput: Double = 1.0 // value the inputed value converts into
    // enum of units
    enum WeightUnit: String {
        case pound = "Pound"
        case ounce = "Ounce"
        case gram = "Gram"
        case kilogram = "Kilogram"
        case usTon = "US ton"
        case metricTon = "Metric ton"
    }
    struct WeightConverter {
        static func convert(value: Double, from: WeightUnit, into: WeightUnit) -> Double {
            let conversionFactors: [WeightUnit: Double] = [
                .pound: 1.0,
                .ounce: 1.0 / 16,
                .gram: 1.0 / 453.592,
                .kilogram: 2.20462,
                .usTon: 2000,
                .metricTon: 2204.62
            ]
            let pounds = value * (conversionFactors[from] ?? 1.0) // always convert to pounds first
            return pounds / (conversionFactors[into] ?? 1.0) // convert to what you actually want
        }
    }

    var body: some View {
            if let fromUnit = WeightUnit(rawValue: selectedUnit),
               let toUnit = WeightUnit(rawValue: convertedUnit) {
                // convert input into output
                let convertedOutput = WeightConverter.convert(value: userInput, from: fromUnit, into: toUnit)
                // display output to 2 decimal places or scientific notation if very large or small
                if convertedOutput == 0 {
                    Text(String(format: "%.2f", convertedOutput))
                } else if 0.01 >= convertedOutput || convertedOutput >= 99999 {
                    Text(String(format: "%.2e", convertedOutput))
                } else {
                    Text(String(format: "%.2f", convertedOutput))
                }
            }
        }
}
