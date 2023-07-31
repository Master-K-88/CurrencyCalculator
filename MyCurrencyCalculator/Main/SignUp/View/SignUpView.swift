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
    private let passwordPrompt: UILabel = UILabel()
    private let confirmPasswordPrompt: UILabel = UILabel()
    var cancellables = Set<AnyCancellable>()
    
    lazy var others = [logoView,
                       registerButton,
                       passwordPrompt,
                       confirmPasswordPrompt]
    lazy var textFields: [UITextField] = [firstNameField,
                                          lastNameField,
                                          passwordField,
                                          confirmPasswordField]
    var viewModel: BaseViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(others + textFields)
        
        logoView.tintColor = .lightGray
        activateButton(activate: false)
        
        textFields.forEach { textField in
            textField.delegate = self
        }
        passwordPrompt.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        confirmPasswordPrompt.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        registerButton.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let width = size.width / 3
        scrollView.frame = self.bounds
        logoView.centerXInSuperView(topAnchor: scrollView.topAnchor,
                                    paddingTop: 20,
                                    width: width,
                                    height: width)
        
        firstNameField.anchor(top: logoView.bottomAnchor,
                              right: scrollView.rightAnchor,
                              left: scrollView.leftAnchor,
                              paddingTop: 20,
                              paddingRight: 30,
                              paddingLeft: 30,
                              width: self.width - 60,
                              height: 52)
        
        lastNameField.anchor(top: firstNameField.bottomAnchor,
                             right: scrollView.rightAnchor,
                             left: scrollView.leftAnchor,
                             paddingTop: 20,
                             paddingRight: 30,
                             paddingLeft: 30,
                             width: self.width - 60,
                             height: 52)
        
        passwordField.anchor(top: lastNameField.bottomAnchor,
                             right: lastNameField.rightAnchor,
                             left: lastNameField.leftAnchor,
                             paddingTop: 20,
                             height: 52)
        passwordPrompt.anchor(top: passwordField.bottomAnchor,
                              left: passwordField.leftAnchor,
                              paddingTop: 5)
        
        confirmPasswordField.anchor(top: passwordField.bottomAnchor,
                                    right: passwordField.rightAnchor,
                                    left: passwordField.leftAnchor,
                                    paddingTop: 20,
                                    height: 52)
        confirmPasswordPrompt.anchor(top: confirmPasswordField.bottomAnchor,
                                     left: confirmPasswordField.leftAnchor,
                                     paddingTop: 5)
        
        registerButton.anchor(top: confirmPasswordField.bottomAnchor,
                              right: passwordField.rightAnchor,
                              left: passwordField.leftAnchor,
                              paddingTop: 20,
                              height: 52)
    }
    
    
    
    @objc
    private func registerButtonTapped(_ sender: UIButton) {
        if let firstName = firstNameField.text,
            let viewModel {
            viewModel.preserveData(value: firstName, key: UserdefaultKeys.firstName.rawValue)
            viewModel.preserveData(value: true, key: UserdefaultKeys.login.rawValue)
            viewModel.signUPSuccessful = true
        }
    }
    
    func configureregisterButton() {
        if let firsName = firstNameField.text,
           let lastName = lastNameField.text,
           let password = passwordField.text,
           let confirmPassword = confirmPasswordField.text,
           !password.isEmpty,
           !confirmPassword.isEmpty {
            let activate = (password == confirmPassword) && !firsName.isEmpty && !lastName.isEmpty
            activateButton(activate: activate)
        }
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

extension SignUpView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.borderWidth = 1
        textField.borderColor = .blue
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, textField == passwordField {
            if text.count < 6 || text.count > 15 {
                passwordPrompt.isHidden = false
                passwordPrompt.text = "Password should be 6 to 15 character in length"
                passwordPrompt.textColor = .red
                textField.borderColor = .red
                textField.borderWidth = 1
            } else {
                passwordPrompt.isHidden = true
            }
        } else {
            passwordPrompt.isHidden = true
        }
        if let text = textField.text, let password = passwordField.text, textField == confirmPasswordField {
            if password != text {
                confirmPasswordPrompt.isHidden = false
                confirmPasswordPrompt.text = "Passwords must match"
                confirmPasswordPrompt.textColor = .red
                textField.borderColor = .red
                textField.borderWidth = 1
            } else {
                confirmPasswordPrompt.isHidden = true
            }
        } else {
            confirmPasswordPrompt.isHidden = true
        }
        textField.borderColor = .lightGray
        configureregisterButton()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = textField.text ?? "" + string
        if textField == passwordField {
            if textField.text ?? "" == passwordField.text ?? "" {
                passwordPrompt.isHidden = true
            } else {
                passwordPrompt.isHidden = false
                passwordPrompt.text = "Password should be 6 to 15 character in length"
                passwordPrompt.textColor = .darkGray
            }
        } else if textField == confirmPasswordField {
            if textField.text ?? "" == confirmPasswordField.text ?? "" {
                confirmPasswordPrompt.isHidden = true
            } else {
                confirmPasswordPrompt.isHidden = false
                confirmPasswordPrompt.text = "Password must match"
                confirmPasswordPrompt.textColor = .darkGray
            }
        }
        
        configureregisterButton()
        
        return true
    }
}
