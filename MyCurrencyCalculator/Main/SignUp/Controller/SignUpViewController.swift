//
//  SignUpViewController.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import UIKit

class SignUpViewController: UIViewController {

    let signupView: SignUpView = SignUpView()
    var viewModel: BaseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(signupView)
//        viewModel?.isUserLoggedIn = true
        view.backgroundColor = .systemBackground
        title = "Sign Up"
        self.navigationItem.largeTitleDisplayMode = .automatic
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signupView.fillSuperView()
    }
    
}
