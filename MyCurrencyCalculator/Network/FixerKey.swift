//
//  FixerKey.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 29/07/2023.
//

import Foundation
protocol FixerKey {
    var apiKey: String { get }
}

extension FixerKey {
    var apiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "FixerAPIKey") as! String
    }
}
