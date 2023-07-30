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
    
    @IBOutlet weak var btnConvertingIcon: UIImageView!
    @IBOutlet weak var btnConvertedIcon: UIImageView!
    
    @IBOutlet weak var convertingTextField: UITextField!
    @IBOutlet weak var convertedTextField: UITextField!
    
    @IBOutlet weak var thirtydaysIndicatorView: UIView!
    @IBOutlet weak var thirtyDaysLabel: UILabel!
    
    @IBOutlet weak var ninetydaysIndicatorView: UIView!
    @IBOutlet weak var ninetyDaysLabel: UILabel!
    
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    
    var viewModel: BaseViewModel = BaseViewModel()
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
        daysViewsTapped(thirtyDaysTapped: true)
        setupConvertingLabel(labelString: "EUR", icon: UIImage(systemName: "person.circle.fill"))
        setupConvertedLabel(labelString: "PLN", icon: UIImage(systemName: "person.circle"))
        // Do any additional setup after loading the view.
//        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "FixerAPIKey") as! String
//        print("here is the build api key: \(currentConfiguration)")
    }
    
    //MARK: Observing user log in state
    func observeViewModel() {
        viewModel.$isUserLoggedIn
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                title = value ? "Username" : ""
                chartView.isHidden = !value
                descriptionView.isHidden = value
            }
            .store(in: &cancellables)
    }
    
    //MARK: Updating Label elements
    internal func setupConvertingLabel(labelString: String, icon: UIImage? = nil) {
        convertingLabel.text = labelString
        btnConvertingLabel.text = labelString
        btnConvertingIcon.image = icon
    }
    
    internal func setupConvertedLabel(labelString: String, icon: UIImage? = nil) {
        convertedLabel.text = labelString
        btnConvertedLabel.text = labelString
        btnConvertedIcon.image = icon
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
    internal func convertingButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction
    internal func convertedButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction
    internal func convertButtonTapped(_ sender: UIButton) {
        
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
        
        let convertingIcon = btnConvertingIcon.image
        let convertedIcon = btnConvertedIcon.image
        
        convertedTextField.text = ""
        
        setupConvertingLabel(labelString: convertedLabelString, icon: convertedIcon)
        setupConvertedLabel(labelString: convertingLabelString, icon: convertingIcon)
    }
}

