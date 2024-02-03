//
//  UIButton + Extension.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import UIKit

extension UIButton {
    convenience init(
        title: String,
        titleFont: UIFont = .systemFont(ofSize: 20, weight: .bold),
        titleColor: UIColor = .white,
        bgColor: UIColor = .link,
        cornerRadius: CGFloat = 12
    ) {
        self.init()
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.setTitleColor(titleColor, for: .normal)
        self.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.titleLabel?.font = titleFont
//        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
}
