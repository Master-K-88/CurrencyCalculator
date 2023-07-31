//
//  SignUpViewController.swift
//  MyCurrencyCalculator
//
//  Created by Prof_K on 16/07/2023.
//

import UIKit
import Combine

class SignUpViewController: UIViewController {

    let signupView: SignUpView = SignUpView()
    var viewModel: BaseViewModel?
    var cancellbales = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(signupView)
        view.backgroundColor = .systemBackground
        title = "Sign Up"
        self.navigationItem.largeTitleDisplayMode = .automatic
        signupView.viewModel = viewModel
        viewModelListener()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signupView.fillSuperView()
    }
    
    private func viewModelListener() {
        viewModel?.$signUPSuccessful
            .receive(on: DispatchQueue.main)
            .sink { [weak self] signedUP in
                guard let self, signedUP else { return }
                navigationController?.popViewController(animated: true)
            }
            .store(in: &cancellbales)
    }
    
}
