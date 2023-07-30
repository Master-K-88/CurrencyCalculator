//
//  UIView + Extension.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        } get {
            layer.cornerRadius
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        } get {
            layer.borderWidth
        }
    }
    
    @IBInspectable
    var borderColor: UIColor {
        set {
            layer.borderColor = newValue.cgColor
        } get {
            UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
    }
}
