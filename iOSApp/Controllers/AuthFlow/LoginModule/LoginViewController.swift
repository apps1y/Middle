//
//  LoginViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit
import AppUI
import SnapKit

enum TextFeildChoise {
    case emailTextField
    case passwordTextField
}


// MARK: - View Protocol
protocol LoginViewProtocol: AnyObject {
    func startLoading()
    
    func finishLoading(with error: (TextFeildChoise, String)?)
}


// MARK: - View Controller
final class LoginViewController: UIViewController {
    
    // MARK: - UI
    private lazy var backgroundScrollView: UIScrollView = {
        let view = UIScrollView()
        view.keyboardDismissMode = .interactiveWithAccessory
        view.alwaysBounceVertical = true
        return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var pageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField: TextField = {
        let field = TextField()
        field.placeholder = "Почта"
        field.keyboardType = .emailAddress
        field.textContentType = .none
        field.delegate = self
        field.returnKeyType = .continue
        return field
    }()
    
    private lazy var passwordTextField: TextField = {
        let field = TextField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        field.textContentType = .none
        field.delegate = self
        field.returnKeyType = .done
        return field
    }()
    
    private lazy var continueButton: Button = {
        let button = Button()
        button.setTitle("Войти", for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var recoverAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Восстановить пароль", for: .normal)
        button.addTarget(self, action: #selector(recoverAccountButtonTapped), for: .touchUpInside)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать аккаунт", for: .normal)
        button.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    var presenter: LoginPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        if #available(iOS 15.0, *) {
            view.keyboardLayoutGuide.topAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        } else {
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        
        view.addSubview(backgroundScrollView)
        backgroundScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundScrollView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(backgroundView.snp.centerY)
            make.height.equalTo(50)
        }
        
        backgroundScrollView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.top.equalTo(backgroundView.snp.centerY).offset(9)
            make.height.equalTo(50)
        }
        
        backgroundScrollView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(backgroundView).inset(20)
            make.height.equalTo(50)
        }
        
        backgroundScrollView.addSubview(pageNameLabel)
        pageNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(emailTextField.snp.top)
            make.top.equalTo(backgroundView)
        }
        
        backgroundScrollView.addSubview(recoverAccountButton)
        recoverAccountButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.height.equalTo(35)
            make.bottom.equalTo(continueButton.snp.top)
        }
        
        backgroundScrollView.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.height.equalTo(35)
            make.bottom.equalTo(recoverAccountButton.snp.top)
        }
    }
    
    // MARK: - @objc funcs
    
    @objc private func continueButtonTapped() {
        guard let email = emailTextField.text else { return }
        presenter?.loginRequest(with: email, password: "")
    }
    
    @objc private func recoverAccountButtonTapped() {
        guard let email = emailTextField.text else { return }
        view.endEditing(true)
        presenter?.openRecover(with: email)
    }
    
    @objc private func createAccountButtonTapped() {
        view.endEditing(true)
        presenter?.openRegistration()
    }
}

// MARK: - View Protocol Realization
extension LoginViewController: LoginViewProtocol {
    func startLoading() {
        view.endEditing(true)
        continueButton.isLoading = true
        emailTextField.mode = .basic
        view.endEditing(true)
        emailTextField.isEnabled = false
        passwordTextField.isEnabled = false
    }
    
    func finishLoading(with error: (TextFeildChoise, String)?) {
        continueButton.isLoading = false
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        
        guard let (field, text) = error else { return }
        // errorLabel.text = text
        switch field {
        case .emailTextField:
            emailTextField.mode = .error
            emailTextField.becomeFirstResponder()
        case .passwordTextField:
            passwordTextField.mode = .error
            passwordTextField.becomeFirstResponder()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }  else if textField == passwordTextField {
            continueButtonTapped()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailTextField && emailTextField.mode == .error {
            emailTextField.mode = .basic
        }
        if textField == passwordTextField && passwordTextField.mode == .error {
            passwordTextField.mode = .basic
        }
        return true
    }
}
