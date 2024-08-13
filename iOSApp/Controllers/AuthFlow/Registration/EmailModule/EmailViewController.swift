//
//  EmailViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit
import AppUI
import SnapKit

// MARK: - View Protocol
protocol EmailViewProtocol: AnyObject {
    
    /// начало анимации загрузки EmailViewController
    func startLoading()
    
    /// завершение анимации загрузки с возможной ошибкой
    /// - Parameters:
    ///   - error: текст ошибки для пользователя (если nil, то ошибки нет)
    func finishLoading(with error: String?)
}

// MARK: - View Controller
final class EmailViewController: UXViewController {
    
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
        label.text = "Регистрация"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField: TextField = {
        let field = TextField()
        field.placeholder = "Введите почту"
        field.keyboardType = .emailAddress
        field.textContentType = .none
        field.delegate = self
        field.returnKeyType = .done
        return field
    }()
    
    private lazy var continueButton: Button = {
        let button = Button()
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Уже есть аккаунт", for: .normal)
        button.setTitleColor(.link, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .center
        return button
    }()
    
    private lazy var errorLabel = ErrorLabel()
    
    var presenter: EmailPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        navigationItem.setHidesBackButton(true, animated: true)
        
        scrollView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(15)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-10)
            make.height.equalTo(47)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(15)
            make.centerY.lessThanOrEqualTo(view.snp.centerY).offset(-50)
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
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
        }
        
        contentView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        contentView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(emailTextField.snp.bottom).offset(4)
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc funcs
    
    @objc private func continueButtonTapped() {
        guard let email = emailTextField.text else { return }
        presenter?.register(with: email)
    }
    
    @objc private func loginButtonTapped() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - View Protocol Realization
extension EmailViewController: EmailViewProtocol {
    func startLoading() {
        continueButton.isLoading = true
        emailTextField.mode = .basic
        view.endEditing(true)
        emailTextField.isEnabled = false
        loginButton.isEnabled = false
        errorLabel.hideWarning()
    }
    
    func finishLoading(with error: String?) {
        continueButton.isLoading = false
        emailTextField.isEnabled = true
        loginButton.isEnabled = true
        
        guard let error else { return }
        errorLabel.showWarning(message: error)
        emailTextField.mode = .error
    }
}


extension EmailViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if emailTextField.mode == .error {
            emailTextField.mode = .basic
            errorLabel.hideWarning()
        }
        
        if string == " " {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        continueButtonTapped()
        return true
    }
}

