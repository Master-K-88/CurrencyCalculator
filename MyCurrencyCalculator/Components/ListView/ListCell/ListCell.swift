//
//  ListCell.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 30/07/2023.
//

import UIKit

class ListCell: UITableViewCell {
    
    static let identifier = "ListCell"
    
    lazy var cellBGView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [cellImageBGView, cellText])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        return stackView
    }()
    let cellImageBGView = UIView()
    let cellText = UILabel()
    let cellFlag = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cellBGView)
        cellImageBGView.addSubview(cellFlag)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutBGView()
        layoutImageView()
        layoutTextView()
    }
    
    private func layoutBGView() {
        cellBGView.fillSuperView()
        cellFlag.fillSuperView(paddingTop: 11, paddingRight: 11, paddingBottom: 11, paddingLeft: 11)
    }
    
    private func layoutImageView() {
        cellImageBGView.sizeForView(width: 40)
    }
    
    private func layoutTextView() {
        cellText.sizeForView(height: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            cellBGView.backgroundColor = .blue.withAlphaComponent(0.05)
        } else {
            cellBGView.backgroundColor = .white
        }
        // Configure the view for the selected state
    }
    
    func setupListData(value: ListItemInterface) {
        cellText.text = value.value
        if let icon = value.icon {
            DispatchQueue.main.async {
                self.cellFlag.text = icon
                self.cellImageBGView.isHidden = false
            }
            
        } else {
            cellImageBGView.isHidden = true
        }
    }

}
