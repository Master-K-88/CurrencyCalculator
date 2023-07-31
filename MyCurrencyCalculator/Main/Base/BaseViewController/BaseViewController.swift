//
//  ViewController.swift
//  MyCurrencyCalculator
//
//  Created by mac on 15/07/2023.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    
    //MARK: User Interface
    @IBOutlet weak var convertingLabel: UILabel!
    @IBOutlet weak var convertedLabel: UILabel!
    
    @IBOutlet weak var btnConvertingLabel: UILabel!
    @IBOutlet weak var btnConvertedLabel: UILabel!
    
    @IBOutlet weak var btnConvertingIcon: UILabel!
    @IBOutlet weak var btnConvertedIcon: UILabel!
    
    @IBOutlet weak var convertingTextField: UITextField!
    @IBOutlet weak var convertedTextField: UITextField!
    
    @IBOutlet weak var thirtydaysIndicatorView: UIView!
    @IBOutlet weak var thirtyDaysLabel: UILabel!
    
    @IBOutlet weak var ninetydaysIndicatorView: UIView!
    @IBOutlet weak var ninetyDaysLabel: UILabel!
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var mainChartView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    @IBOutlet weak var convertingView: UIView!
    @IBOutlet weak var convertedView: UIView!
    
    let chartDetailView = ChartView()
    
    lazy var convertingDropdownView = MenuListView(
        listData: viewModel.listItem,
        selectedValue: SelectedItemConverting,
        parentView: self.view,
        frame: convertingView.frame,
        hideLabel: true,
        cellHeight: 50)
    
    lazy var convertedDropdownView = MenuListView(
        listData: viewModel.listItem,
        selectedValue: SelectedItemConverted,
        parentView: self.view,
        frame: convertingView.frame,
        hideLabel: true,
        cellHeight: 50)
    
    var viewModel: BaseViewModel = BaseViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        daysViewsTapped(thirtyDaysTapped: true)
        setupConvertingLabel(labelString: "EUR", icon: viewModel.getFlag(for: "EUR"))
        setupConvertedLabel(labelString: "PLN", icon: viewModel.getFlag(for: "PLN"))
        // Do any additional setup after loading the view.
        convertingView.addSubview(convertingDropdownView)
        convertedView.addSubview(convertedDropdownView)
        
        [convertingTextField, convertedTextField].forEach { textField in
            textField?.delegate = self
            textField?.keyboardType = .numberPad
        }
        
        chartView.addSubview(chartDetailView)
        chartDetailView.fillSuperView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        convertingDropdownView.fillSuperView()
        convertedDropdownView.fillSuperView()
        convertingDropdownView.cornerRadius = 5
        convertedDropdownView.cornerRadius = 5
    }
    
    //MARK: Observing user log in state
    func observeViewModel() {
        viewModel.$isUserLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                let username = viewModel.retreiveData(UserdefaultKeys.firstName.rawValue, of: String.self) ?? ""
                title = value ? "\(username)" : ""
                chartView.isHidden = !value
                navigationItem.rightBarButtonItem?.isHidden = value
                descriptionView.isHidden = value
            }
            .store(in: &cancellables)
    }
    
    //MARK: Updating Label elements
    internal func setupConvertingLabel(labelString: String, icon: String? = nil) {
        convertingLabel.text = labelString
        btnConvertingLabel.text = labelString
        btnConvertingIcon.text = icon
    }
    
    internal func setupConvertedLabel(labelString: String, icon: String? = nil) {
        convertedLabel.text = labelString
        btnConvertedLabel.text = labelString
        btnConvertedIcon.text = icon
    }
    
    //MARK: Handling Signup Tapped by Presenting the Signup View
    @IBAction
    internal func signupTapped(_ sender: UIBarButtonItem) {
        let signUpVC = SignUpViewController()
        signUpVC.viewModel = viewModel
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    //MARK: Handling swap tap
    @IBAction
    internal func swapConverter(_ sender: UIButton) {
        swapTapped()
    }
    
    @IBAction
    internal func convertButtonTapped(_ sender: UIButton) {
        print("Will be converting the currency here")
    }
    
    @IBAction
    internal func thirtyDaysTapped(_ sender: UIButton) {
        daysViewsTapped(thirtyDaysTapped: true)
    }
    
    @IBAction
    internal func ninetyDaysTapped(_ sender: UIButton) {
        daysViewsTapped(thirtyDaysTapped: false)
    }
    
    /// Days Selection Type Updater
    /// UI selection Updater
    /// Input: Bool specifying whether it was thirtyDays that was selected or not
    /// Process: Checks the view selected to Update appropriately
    /// Output: UI update.
    internal func daysViewsTapped(thirtyDaysTapped: Bool) {
        thirtyDaysLabel.textColor = thirtyDaysTapped ?
            .white :
            .white.withAlphaComponent(0.6)
        thirtydaysIndicatorView.isHidden = thirtyDaysTapped ? false : true
        ninetyDaysLabel.textColor = thirtyDaysTapped ?
            .white.withAlphaComponent(0.6) :
            .white
        ninetydaysIndicatorView.isHidden = thirtyDaysTapped ? true : false
    }
    
    internal func swapTapped() {
        let convertingLabelString = convertingLabel.text ?? ""
        let convertedLabelString = convertedLabel.text ?? ""
        
        let convertingIcon = btnConvertingIcon.text
        let convertedIcon = btnConvertedIcon.text
        
        convertedTextField.text = ""
        
        setupConvertingLabel(labelString: convertedLabelString, icon: convertedIcon)
        setupConvertedLabel(labelString: convertingLabelString, icon: convertingIcon)
    }
    
    func SelectedItemConverting(_ item: ListItemInterface) {
        btnConvertingLabel.text = item.value
        btnConvertingIcon.text = item.icon
        convertingLabel.text = item.value
    }
    
    func SelectedItemConverted(_ item: ListItemInterface) {
        btnConvertedLabel.text = item.value
        btnConvertedIcon.text = item.icon
        convertedLabel.text = item.value
    }
}


extension BaseViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var text = textField.text ?? "" + string
        text = text.replacingOccurrences(of: ",", with: "")
        textField.text = text.formattedValue
        return true
    }
}
