//
//  Double + Extension.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import Foundation

extension Double {
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = .current
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

extension String {
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = .current
        return formatter.string(from: NSNumber(value: Double(Int(self) ?? 0))) ?? ""
    }
}
