//
//  NewPasswordRecViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 23.07.2024
//

import UIKit
import AppUI
import SnapKit

// MARK: - View Protocol
protocol NewPasswordRecViewProtocol: AnyObject {
    
    /// начало анимации загрузки LoginViewController
    func startLoading()
    
    /// завершение анимации загрузки с возможной ошибкой
    /// - Parameters:
    ///   - error: какое поле загорится красным, текст ошибки для пользователя
    func finishLoading(with error: (PasswordFieldChoise, String)?)
}

// MARK: - View Controller
final class NewPasswordRecViewController: UXViewController {
    
    // MARK: - UI
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Придумайте пароль"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var firstPasswordTextField: TextField = {
        let field = TextField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        field.delegate = self
        field.returnKeyType = .done
        field.addShowPasswordButton()
        return field
    }()
    
    private lazy var secondPasswordTextField: TextField = {
        let field = TextField()
        field.placeholder = "Повторите пароль"
        field.isSecureTextEntry = true
        field.delegate = self
        field.returnKeyType = .done
        field.addShowPasswordButton()
        return field
    }()
    
    private lazy var continueButton: Button = {
        let button = Button()
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "onboardingLogo")
        return view
    }()
    
    private lazy var errorLabel = ErrorLabel()
    
    var presenter: NewPasswordRecPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(backButtonTapped))
        
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
        
        contentView.addSubview(firstPasswordTextField)
        firstPasswordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        contentView.addSubview(secondPasswordTextField)
        secondPasswordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
            make.top.equalTo(firstPasswordTextField.snp.bottom).offset(10)
        }
        
        contentView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(5)
            make.top.equalTo(secondPasswordTextField.snp.bottom).offset(4)
            make.height.greaterThanOrEqualTo(20)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc func
    
    @objc private func continueButtonTapped() {
        guard let firstPassword = firstPasswordTextField.text,
                let secondPassword = secondPasswordTextField.text else { return }
        presenter?.create(firstPassword: firstPassword, secondPassword: secondPassword)
    }
    
    @objc private func backButtonTapped() {
        /// на предыдущий экран
        view.endEditing(true)
        dismiss(animated: true)
    }
}

// MARK: - View Protocol Realization
extension NewPasswordRecViewController: NewPasswordRecViewProtocol {
    
    func startLoading() {
        view.endEditing(true)
        continueButton.isLoading = true
        firstPasswordTextField.isEnabled = false
        secondPasswordTextField.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        errorLabel.hideWarning()
    }
    
    func finishLoading(with error: (PasswordFieldChoise, String)?) {
        continueButton.isLoading = false
        firstPasswordTextField.isEnabled = true
        secondPasswordTextField.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        errorLabel.hideWarning()
        
        guard let (field, text) = error else { return }
        errorLabel.showWarning(message: text)
        // errorLabel.text = text
        switch field {
        case .first:
            firstPasswordTextField.mode = .error
            firstPasswordTextField.becomeFirstResponder()
        case .second:
            secondPasswordTextField.mode = .error
            secondPasswordTextField.becomeFirstResponder()
        case .none: break
        }
    }
}

extension NewPasswordRecViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstPasswordTextField {
            secondPasswordTextField.becomeFirstResponder()
        }  else if textField == secondPasswordTextField {
            continueButtonTapped()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        errorLabel.hideWarning()
        
        if textField == firstPasswordTextField && firstPasswordTextField.mode == .error {
            firstPasswordTextField.mode = .basic
        }
        if textField == secondPasswordTextField && secondPasswordTextField.mode == .error {
            secondPasswordTextField.mode = .basic
        }
        
        if string == " " {
            return false
        }
        return true
    }
}

