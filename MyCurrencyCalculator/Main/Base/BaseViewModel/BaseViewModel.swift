//
//  BaseViewModel.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import Foundation

final class BaseViewModel: UserDefaultServiceInterface {
    
    @Published var isUserLoggedIn: Bool = false
    
    init() {
        getUserLoginState()
    }
    
    func getUserLoginState() {
        if let userLoggedIn = retreiveData(UserdefaultKeys.login.rawValue, of: Bool.self) {
            isUserLoggedIn = userLoggedIn
        }
    }
    
    func convertCurrency(newAmount: Double, oldToValue: Double, oldFromValue: Double) -> Double {
        newAmount * oldToValue / oldFromValue
    }
}

extension BaseViewModel: ServiceProtocol { }
