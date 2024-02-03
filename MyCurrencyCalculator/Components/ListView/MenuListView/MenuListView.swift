//
//  MenuListView.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//


import UIKit

class MenuListView: UIView, ListInterface {
    
    var cellHeight: Int = 52
    var selectedValue: ((ListItemInterface) -> ())?
    var transparentView: UIView = UIView()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
         tableView.register(
             ListCell.self,
             reuseIdentifier: ListCell.identifier
         )
         tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
         tableView.rowHeight = 52
         return tableView
     }()
    var parentView: UIView?
    lazy var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissDropDown))
    lazy var heightConstraints = NSLayoutConstraint(
        item: tableView,
        attribute: .height,
        relatedBy: .equal,
        toItem: nil,
        attribute: .notAnAttribute,
        multiplier: 1,
        constant: 0
    )
    var frames: CGRect?
    var menuItems: [ListItemInterface] = []
    var showDropDowButton = UIButton()
    var titleText: String = "" {
        didSet {
            print("I am here showing \(titleText)")
            DispatchQueue.main.async {
                self.valueLabel.text = self.titleText
                self.valueLabel.textColor = .label
            }
            
        }
    }
    var valueLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(valueLabel)
        borderWidth = 1
        borderColor = .blue.withAlphaComponent(0.2)
        cornerRadius = 10
        backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        valueLabel.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        valueLabel.sizeForView(height: 20)
        valueLabel.centerYInSuperView(leftAnchor: leftAnchor, paddingLeft: 20)
        let showDropDownGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(showDropDownTapped))
        addGestureRecognizer(showDropDownGesture)
        self.valueLabel.textColor = .label
        transparentView.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissDropDown() {
        removeTransparentViewFromView()
    }
    
    convenience init(
        listData: [ListItemInterface],
        selectedValue: ((ListItemInterface) -> ())? = nil,
        parentView: UIView? = nil,
        frame: CGRect? = nil,
        hideLabel: Bool = false,
        cellHeight: Int = 52
    ) {
        self.init(frame: .zero)
        self.menuItems = listData
        self.selectedValue = selectedValue
        self.parentView = parentView
        self.frames = frame
        self.valueLabel.text = menuItems.first?.value
        self.valueLabel.isHidden = hideLabel
        self.cellHeight = cellHeight
    }
    
    @objc func showDropDownTapped() {
        if let parentView {
            addTransparentView(on: parentView, below: self)
        }
    }
}


extension MenuListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = menuItems[indexPath.row]
        let cell = tableView.dequeue(ListCell.self, for: indexPath)
        cell.setupListData(value: model)
        return cell
    }
    
    
}

extension MenuListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = menuItems[indexPath.row]
        selectedValue?(model)
        removeTransparentViewFromView()
    }
}
