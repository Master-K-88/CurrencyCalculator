//
//  UserDefaultManager.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import Foundation

protocol UserDefaultManager {
    func setData(value: Data, key: String) throws
    func getData(key: String) throws -> Data?
    func deleteData(key: String) throws
    func deleteAllData() throws
}

extension UserDefaultManager {
    func setData(value: Data, key: String) throws {
        UserDefaults.standard.set(value, forKey: key)
    }
    func getData(key: String) throws -> Data? {
        return UserDefaults.standard.data(forKey: key)
    }
    func deleteData(key: String) throws {
        UserDefaults.standard.removeObject(forKey: key)
    }
    func deleteAllData() throws {
        if let identifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: identifier)
            UserDefaults.standard.synchronize()
        }
    }
}
