//
//  ListViewPropertyInterface.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import UIKit

protocol ListViewInterface {
    var transparentView: UIView { get set }
    var tableView: UITableView { get set }
    var tapGesture: UITapGestureRecognizer { get set }
    var heightConstraints: NSLayoutConstraint { get set}
    var cellHeight: Int { get set }
    var frames: CGRect? { get set }
}



protocol ListInterface: ListViewInterface, ListViewDataInterface {
    func addTransparentView(on bgView: UIView, below item: UIView)
}

