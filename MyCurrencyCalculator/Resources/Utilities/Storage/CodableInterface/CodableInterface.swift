//
//  CodableInterface.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import Foundation
protocol CodableInterface {
    func encodeData<T: Codable>(_ value: T) -> Data?
    func decodeData<T: Codable>(_ type: T.Type, from data: Data) -> T?
}

extension CodableInterface {
    func encodeData<T: Codable>(_ value: T) -> Data? {
        let encoder = JSONEncoder()
        
        do {
            let encoded = try encoder.encode(value)
            return encoded
        }
        catch {
            print("Unable to encode data: \(value)")
            return nil
        }
    }
    
    func decodeData<T: Codable>(_ type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let decoded = try decoder.decode(type, from: data)
            return decoded
        }
        catch {
            print("Unable to decode data")
            return nil
        }
    }
}
