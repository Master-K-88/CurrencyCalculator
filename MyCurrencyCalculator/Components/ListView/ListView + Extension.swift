//
//  ListView + Extension.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import UIKit

extension ListInterface {
    func addTransparentView(on bgView: UIView, below item: UIView) {
        guard let frames = frames else { return }
        var height = CGFloat(menuItems.count * cellHeight)
        if height + frames.height + frames.origin.y + 100 > (bgView.bounds.height - frames.origin.y) {
            height = CGFloat(5 * cellHeight)
        }
        bgView.addSubview(transparentView)
        transparentView.frame = bgView.frame
        
        bgView.addSubview(tableView)
        tableView.anchor(top: item.bottomAnchor, right: item.rightAnchor, left: item.leftAnchor, paddingTop: 5)
        tableView.addConstraint(heightConstraints)
        
        transparentView.isHidden = false
        tableView.cornerRadius = 10
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.borderWidth = 1
        tableView.borderColor = .blue.withAlphaComponent(0.1)
        
        transparentView.addGestureRecognizer(tapGesture)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            transparentView.alpha = 0.5
            
                DispatchQueue.main.async {
                    tableView.isHidden = false
                    heightConstraints.constant = height
                }
        }, completion: nil)

    }
    
    func removeTransparentViewFromView() {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut) {
            let height = CGFloat(menuItems.count * 52)
                DispatchQueue.main.async {
                    heightConstraints.constant = 0
                    tableView.isHidden = true
                }
        } completion: { complete in
            if complete {
                transparentView.isHidden = true
                tableView.removeFromSuperview()
            }
        }
    }
}
