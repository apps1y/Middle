//
//  LoginViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 15.07.2024
//

import UIKit
import AppUI
import SnapKit

/// какое поле загорится красным
enum TextFeildChoise {
    case emailTextField
    case passwordTextField
}


// MARK: - View Protocol
protocol LoginViewProtocol: AnyObject {
    
    /// начало анимации загрузки LoginViewController
    func startLoading()
    
    /// завершение анимации загрузки с возможной ошибкой
    /// - Parameters:
    ///   - error: какое поле загорится красным, текст ошибки для пользователя
    func finishLoading(withErrorOf field: TextFeildChoise?)
}


// MARK: - View Controller
final class LoginViewController: UXViewController {
    
    // MARK: - UI
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "onboardingLogo")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
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
        field.autocapitalizationType = .none
        field.delegate = self
        field.returnKeyType = .continue
        return field
    }()
    
    private lazy var passwordTextField: TextField = {
        let field = TextField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        field.delegate = self
        field.returnKeyType = .done
        field.addShowPasswordButton()
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
        button.setTitle("Забыли пароль?", for: .normal)
        button.addTarget(self, action: #selector(recoverAccountButtonTapped), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .center
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
        
        scrollView.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.leading.trailing.equalTo(view).inset(15)
            make.height.equalTo(45)
        }

        scrollView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(15)
            make.bottom.greaterThanOrEqualTo(createAccountButton.snp.top).offset(-5)
            make.bottom.lessThanOrEqualTo(keyboardLayoutGuide.snp.top).offset(-10)
            make.height.equalTo(47)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(15)
            make.centerY.lessThanOrEqualTo(view.snp.centerY).offset(-70)
            make.bottom.lessThanOrEqualTo(continueButton.snp.top).offset(-30)
        }
        
        contentView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(min(view.frame.size.height * 0.25, 200))
            make.centerX.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(7)
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
        }
        
        contentView.addSubview(recoverAccountButton)
        recoverAccountButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc funcs
    
    @objc private func continueButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter?.login(with: email, password: password)
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
    
    // MARK: - private funcs
    
    
}

// MARK: - View Protocol Realization
extension LoginViewController: LoginViewProtocol {
    func startLoading() {
        view.endEditing(true)
        continueButton.isLoading = true
        emailTextField.mode = .basic
        emailTextField.isEnabled = false
        passwordTextField.isEnabled = false
    }
    
    func finishLoading(withErrorOf field: TextFeildChoise?) {
        continueButton.isLoading = false
        emailTextField.isEnabled = true
        passwordTextField.isEnabled = true
        
        emailTextField.mode = .basic
        passwordTextField.mode = .basic
        guard let field else { return }
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
        
        if string == " " {
            return false
        }
        return true
    }
}
