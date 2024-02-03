//
//  ListViewInterface.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import Foundation

protocol ListItemInterface {
    var value: String? { get set }
    var icon: String? { get set }
}

protocol ListViewDataInterface {
    var menuItems: [ListItemInterface] { get set}
}

