//
//  UIView + Extension + AutoLayout.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import UIKit

extension UIView {
    
    var size: CGSize {
        return self.frame.size
    }
    
    var width: CGFloat {
        return self.frame.size.width
    }
    
    var height: CGFloat {
        return self.frame.size.height
    }
    
    var top: CGFloat {
        return self.frame.origin.y
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingRight: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        sizeForView(width: width, height: height)
    }
    
    func centerXInSuperView(topAnchor: NSLayoutYAxisAnchor? = nil,
                            bottomAnchor: NSLayoutYAxisAnchor? = nil,
                            paddingTop: CGFloat = 0,
                            paddingBottom: CGFloat = 0,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop).isActive = true
        }
        
        if let bottomAnchor {
            self.topAnchor.constraint(equalTo: bottomAnchor, constant: -paddingBottom).isActive = true
        }
        
        if let superview {
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        }
        
        sizeForView(width: width, height: height)
    }
    
    func centerYInSuperView(leftAnchor: NSLayoutXAxisAnchor? = nil,
                            rightAnchor: NSLayoutXAxisAnchor? = nil,
                            paddingLeft: CGFloat = 0,
                            paddingRight: CGFloat = 0,
                            width: CGFloat? = nil,
                            height: CGFloat? = nil
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let leftAnchor {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: paddingLeft).isActive = true
        }
        
        if let rightAnchor {
            self.leftAnchor.constraint(equalTo: rightAnchor, constant: -paddingRight).isActive = true
        }
        
        if let superview {
            self.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        }
    }
    
    func sizeForView(width: CGFloat? = nil, height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let width {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func fillSuperView(paddingTop: CGFloat = 0,
                       paddingRight: CGFloat = 0,
                       paddingBottom: CGFloat = 0,
                       paddingLeft: CGFloat = 0
    ) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview {
            self.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor, constant: paddingTop).isActive = true
            self.rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor, constant: -paddingRight).isActive = true
            self.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor, constant: -paddingBottom).isActive = true
            self.leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor, constant: paddingLeft).isActive = true
        }
    }
    
    func addSubview(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }
}
