//
//  UserDefaultServiceInterface.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import Foundation

protocol UserDefaultServiceInterface: CodableInterface, UserDefaultManager {
    //MARK: This performs the Read
    func retreiveData<T: Codable>(_ key: String,
                                  of type: T.Type) -> T?
    //MARK: This performs Create and Update
    func preserveData<T: Codable>(value: T,
                                  key: String)
    //MARK: This performs the Delete either single item or the entire collection of items
    func deleteAllStored()
    func deleteSpecificData<T: Codable>(with key: String, of type: T.Type)
}

extension UserDefaultServiceInterface {
    //MARK: This performs the Read
    func retreiveData<T: Codable>(_ key: String,
                                  of type: T.Type) -> T? {
        guard let data = try? getData(key: key) else { return nil}
        return decodeData(type, from: data)
    }
    //MARK: This performs Create and Update
    func preserveData<T: Codable>(value: T,
                                  key: String) {
        guard let data = encodeData(value) else { return }
        try? setData(value: data, key: key)
    }
    //MARK: This performs the Delete either single item or the entire collection of items
    func deleteAllStored() {
        try? deleteAllData()
    }
    func deleteSpecificData<T: Codable>(with key: String,
                                        of type: T.Type) {
        try? deleteData(key: key)
    }
}
