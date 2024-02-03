//
//  GetFlagInterface.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 29/07/2023.
//

import UIKit

protocol GetFlagInterface {
    func getFlag(for currency: String) -> String
}

extension GetFlagInterface {
    func getFlag(for currency: String) -> String {
        let base: UInt32 = 127397
        var code = currency.prefix(2).uppercased()
        print("Here is the country code: \(code)")

        var flag = ""
        for i in code.unicodeScalars {
            if let scalarValue = UnicodeScalar(base + i.value) {
                flag.append(String(scalarValue))
            }
        }
        print("Here is the country flag: \(flag)")
        return flag
    }
}


struct Currency: Identifiable {
    var id = UUID().uuidString
    var currencyName: String
    var currencyValue: Double
}
