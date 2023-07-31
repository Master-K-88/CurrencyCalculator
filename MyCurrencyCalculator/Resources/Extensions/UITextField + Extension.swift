//
//  UITextField + Extension.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import UIKit

extension UITextField {
    convenience init(placeholder: String, isSecureField: Bool) {
        self.init()
        self.autocapitalizationType = .none
        self.autocorrectionType = .no
        self.returnKeyType = isSecureField ? .done : .continue
        self.cornerRadius = 10
        self.borderWidth = 1
        self.borderColor = .lightGray
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftViewMode = .always
        self.backgroundColor = .systemBackground
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureField
    }
}
