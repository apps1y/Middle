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
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(-15)
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
        
        backgroundScrollView.addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundView).inset(10)
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.height.equalTo(40)
        }
        
        backgroundScrollView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(createAccountButton.snp.top).offset(-5)
            make.height.equalTo(50)
        }
        
        backgroundScrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(emailTextField.snp.top)
            make.height.greaterThanOrEqualTo(70)
        }
        
        backgroundScrollView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView)
            make.leading.trailing.equalTo(backgroundView)
            make.bottom.equalTo(titleLabel.snp.top)
            make.height.lessThanOrEqualTo(200)
        }
        
        backgroundScrollView.addSubview(recoverAccountButton)
        recoverAccountButton.snp.makeConstraints { make in
            make.leading.equalTo(backgroundView).inset(20)
            make.height.equalTo(30)
            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
        }
    }
    
    // MARK: - @objc funcs
    
    @objc private func continueButtonTapped() {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        presenter?.login(with: email, password: password)
    }
    
    @objc private func recoverAccountButtonTapped() {
        guard let email = emailTextField.text else { return }
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
        
        if string.count > 1 || string == " " {
            return false
        }
        return true
    }
}
