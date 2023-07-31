//
//  BaseViewModel.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import Foundation
import Combine

final class BaseViewModel: UserDefaultServiceInterface {
    
    @Published var isUserLoggedIn: Bool = false
    @Published var signUPSuccessful: Bool = false
    var listItem: [ListItemInterface] = []
    @Published var thirtyDayValue: [Double] = .init(repeating: 0, count: 30)
    @Published var ninetyDaysValue: [Double] = .init(repeating: 0, count: 90)
    @Published var cancellables = Set<AnyCancellable>()
    
    enum SelectedDays {
        case thirtyDay, ninetyDays
        
        var stringValue: String {
            switch self {
            case .ninetyDays:
                return "90 Days"
            case .thirtyDay:
                return "30 Days"
            }
        }
    }
    
    var selectedDays: SelectedDays = .thirtyDay
    
    init() {
        getUserLoginState()
        self.listItem = listTestItem
        getConvertingData()
    }
    
    func getUserLoginState() {
        if let userLoggedIn = retreiveData(UserdefaultKeys.login.rawValue, of: Bool.self) {
            isUserLoggedIn = userLoggedIn
        }
    }
    
    func getConvertingData() {
        let endpoint = "http://data.fixer.io/api/latest?access_key=91be1bb7e8da27062001e413f9bebf58"
        requestWithParameter(url: endpoint, method: .get, parameters: [:])
            .receive(on: DispatchQueue.main)
            .sink { completed in
                switch completed {
                case.finished:
                    print("Completed")
                case .failure(let error):
                    print("An error occured: \(error.localizedDescription)")
                }
            } receiveValue: { json in
                print("Here is the response \(json)")
            }
            .store(in: &cancellables)

    }
    
    func convertCurrency(newAmount: Double, oldToValue: Double, oldFromValue: Double) -> Double {
        newAmount * oldToValue / oldFromValue
    }
    
    var lineData: [Double] {
        switch selectedDays {
        case .thirtyDay:
            return thirtyDayValue
        case .ninetyDays:
            return ninetyDaysValue
        }
    }
}

extension BaseViewModel: ServiceProtocol { }
extension BaseViewModel: GetFlagInterface { }
extension BaseViewModel: TestData { }


protocol TestData: GetFlagInterface {
    var listTestItem: [ListItemInterface] { get }
}

extension TestData {
    var listTestItem: [ListItemInterface] {
        [
            ListModel(value: "AUD", icon: getFlag(for: "AUD")),
            ListModel(value: "CAD", icon: getFlag(for: "CAD")),
            ListModel(value: "CHF", icon: getFlag(for: "CHF")),
            ListModel(value: "CNY", icon: getFlag(for: "CNY")),
            ListModel(value: "GBP", icon: getFlag(for: "GBP")),
            ListModel(value: "JPY", icon: getFlag(for: "JPY")),
            ListModel(value: "USD", icon: getFlag(for: "USD")),
            ListModel(value: "NGN", icon: getFlag(for: "NGN"))
        ]
    }
}
