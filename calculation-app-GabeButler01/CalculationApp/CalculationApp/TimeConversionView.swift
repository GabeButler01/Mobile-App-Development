//
//  TimeConversionView.swift
//  CalculationApp
//
//  Created by Gabe Butler on 10/19/24.
//

import SwiftUI

struct TimeConversionView: View {
    @Binding var selectedUnit: String // unit picked at top of page (from)
    @Binding var convertedUnit: String // unit picked at bottom of page (to)
    @Binding var userInput: Double // value user inputs
    @State private var convertedInput: Double = 1.0 // value the inputed value converts into
    // enum of units
    enum TimeUnit: String {
        case millisecond = "Millisecond"
        case second = "Second"
        case minute = "Minute"
        case hour = "Hour"
        case day = "Day"
        case week = "Week"
        case month = "Month"
        case year = "Year"
    }
    struct TimeConverter {
        static func convert(value: Double, from: TimeUnit, into: TimeUnit) -> Double {
            let conversionFactors: [TimeUnit: Double] = [
                .millisecond: 1.0,
                .second: 1000,
                .minute: 60000,
                .hour: 3600000,
                .day: 86400000,
                .week: 604800000,
                .month: 2628000000,
                .year: 31540000000
            ]
            let millisecond = value * (conversionFactors[from] ?? 1.0) // always convert to milliseconds first
            return millisecond / (conversionFactors[into] ?? 1.0) // convert to what you actually want
        }
    }

    var body: some View {
            if let fromUnit = TimeUnit(rawValue: selectedUnit),
               let toUnit = TimeUnit(rawValue: convertedUnit) {
                // convert input into output
                let convertedOutput = TimeConverter.convert(value: userInput, from: fromUnit, into: toUnit)
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
