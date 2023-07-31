//
//  RealmServiceInterface.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import Foundation
import RealmSwift


protocol RealmServiceInterface {
    var realm: Realm { get }
    func setData<T: Object>(object: T, key: String) throws
    func getData<T: Object>(key: String, of type: T.Type) throws -> Results<T>?
    func deleteData<T: Object>(_ object: T) throws
    func deleteAllData() throws
}

extension RealmServiceInterface {
    func setData<T: Object>(object: T, key: String) throws {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            throw error
        }
    }
    func getData<T: Object>(key: String, of type: T.Type) throws -> Results<T>? {
        return realm.objects(type)
    }
    func deleteData<T: Object>(_ object: T) throws {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            throw error
        }
    }
    func deleteAllData() throws {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            throw error
        }
    }
}
