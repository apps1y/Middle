//
//  LoginViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit

// MARK: - View Protocol
protocol LoginViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class LoginViewController: UIViewController {
    
    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - View Protocol Realization
extension LoginViewController: LoginViewProtocol {
    
}
