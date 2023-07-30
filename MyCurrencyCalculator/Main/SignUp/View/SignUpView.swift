//
//  SignUpView.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import Combine
import UIKit

final class SignUpView: UIView {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    let logoView: UIImageView = UIImageView(
        image: UIImage(systemName: "person.circle.fill")
    )
    
    private let firstNameField: UITextField = UITextField(placeholder: "First Name...",
                                                      isSecureField: false)
    private let lastNameField: UITextField = UITextField(placeholder: "Last Name...",
                                                      isSecureField: false)
    private let passwordField: UITextField = UITextField(placeholder: "Password...",
                                                         isSecureField: true)
    private let confirmPasswordField: UITextField = UITextField(
        placeholder: "Confirm Password...",
        isSecureField: true)
    private let registerButton: UIButton = UIButton(title: "Register")
    var cancellables = Set<AnyCancellable>()
    
    lazy var others = [logoView,
                       registerButton]
    lazy var textFields = [firstNameField,
                           lastNameField,
                           passwordField,
                           confirmPasswordField]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(others + textFields)
        configureregisterButton()
        
        logoView.tintColor = .lightGray
        activateButton(activate: false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = size.width / 3
        scrollView.frame = self.bounds
        logoView.centerXInSuperView(topAnchor: scrollView.topAnchor,
                                    paddingTop: 5,
                                    width: width,
                                    height: width)
        
        firstNameField.anchor(top: logoView.bottomAnchor,
                          right: scrollView.rightAnchor,
                          left: scrollView.leftAnchor,
                          paddingTop: 10,
                          paddingRight: 30,
                          paddingLeft: 30,
                          width: self.width - 60,
                          height: 52)
        
        lastNameField.anchor(top: firstNameField.bottomAnchor,
                          right: scrollView.rightAnchor,
                          left: scrollView.leftAnchor,
                          paddingTop: 10,
                          paddingRight: 30,
                          paddingLeft: 30,
                          width: self.width - 60,
                          height: 52)
        
        passwordField.anchor(top: lastNameField.bottomAnchor,
                             right: lastNameField.rightAnchor,
                             left: lastNameField.leftAnchor,
                             paddingTop: 10,
                             height: 52)
        
        confirmPasswordField.anchor(top: passwordField.bottomAnchor,
                             right: passwordField.rightAnchor,
                             left: passwordField.leftAnchor,
                             paddingTop: 10,
                             height: 52)
        
        registerButton.anchor(top: confirmPasswordField.bottomAnchor,
                             right: passwordField.rightAnchor,
                             left: passwordField.leftAnchor,
                             paddingTop: 10,
                             height: 52)
    }
    
    
    
    @objc
    private func registerButtonTapped(_ sender: UIButton) {
        
    }
    
    func configureregisterButton() {
        
    }
    
    func setupTextField(textField: UITextField, borderWidth: CGFloat = 1, borderColor: UIColor = .black) {
        textField.borderWidth = borderWidth
        textField.borderColor = borderColor
    }
    
    func checkEmptyStrings(email: String, password: String) {
         if password.isEmpty {
            passwordField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            setupTextField(textField: passwordField, borderWidth: 1, borderColor: .red)
        }
        else {
            activateButton(activate: true)
        }
    }
    
    func activateButton(activate: Bool) {
        registerButton.isUserInteractionEnabled = activate
        registerButton.backgroundColor = activate ? .systemGreen : .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
