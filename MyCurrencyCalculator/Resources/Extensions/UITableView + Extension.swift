//
//  UITableView + Extension.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(_: T.Type, reuseIdentifier: String? = nil) {
        let reuseId = reuseIdentifier ?? "\(T.self)"
        self.register(T.self, forCellReuseIdentifier: reuseId)
    }
    
    func dequeue<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath? = nil) -> T {
        if let indexPath = indexPath {
            guard
                let cell = dequeueReusableCell(withIdentifier: String(describing: T.self),
                                               for: indexPath) as? T
                else { fatalError("Could not dequeue cell with type \(T.self)") }
            return cell
            
        }
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T
            else { fatalError("Could not dequeue header cell with type \(T.self)") }
        return cell
    }
}
