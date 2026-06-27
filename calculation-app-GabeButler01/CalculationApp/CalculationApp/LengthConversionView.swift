//
//  LengthConversionView.swift
//  CalculationApp
//
//  Created by Gabe Butler on 10/19/24.
//

import SwiftUI

struct LengthConversionView: View {
    @Binding var selectedUnit: String // unit picked at top of page (from)
    @Binding var convertedUnit: String // unit picked at bottom of page (to)
    @Binding var userInput: Double // value user inputs
    @State private var convertedInput: Double = 1.0 // value the inputed value converts into
    // enum of units
    enum LengthUnit: String {
        case inch = "Inch"
        case foot = "Foot"
        case yard = "Yard"
        case mile = "Mile"
        case millimeter = "Millimeter"
        case centimeter = "Centimeter"
        case meter = "Meter"
        case kilometer = "Kilometer"
    }
    // convert units
    struct LengthConverter {
        static func convert(value: Double, from: LengthUnit, into: LengthUnit) -> Double {
            let conversionFactors: [LengthUnit: Double] = [
                .inch: 1.0,
                .foot: 12,
                .yard: 36,
                .mile: 63360,
                .millimeter: 1.0 / 25.4,
                .centimeter: 1.0 / 2.54,
                .meter: 39.37,
                .kilometer: 39370
            ]
            let inches = value * (conversionFactors[from] ?? 1.0) // always convert to inches first
            return inches / (conversionFactors[into] ?? 1.0) // convert to what you actually want
        }
    }

    var body: some View {
            if let fromUnit = LengthUnit(rawValue: selectedUnit),
               let toUnit = LengthUnit(rawValue: convertedUnit) {
                    // convert input into output
                    let convertedOutput = LengthConverter.convert(value: userInput, from: fromUnit, into: toUnit)
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
