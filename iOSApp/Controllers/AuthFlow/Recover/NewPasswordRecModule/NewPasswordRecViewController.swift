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
final class NewPasswordRecViewController: UIViewController {
    
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
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(
                -(navigationController?.navigationBar.frame.size.height ?? -25)
            )
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
        
        backgroundScrollView.addSubview(firstPasswordTextField)
        firstPasswordTextField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(backgroundView.snp.centerY)
            make.height.equalTo(50)
        }
        
        backgroundScrollView.addSubview(secondPasswordTextField)
        secondPasswordTextField.snp.makeConstraints { make in
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
        
        backgroundScrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(firstPasswordTextField.snp.top)
            make.height.greaterThanOrEqualTo(70)
        }
        
        backgroundScrollView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView)
            make.centerX.equalTo(backgroundView)
            make.width.equalTo(200)
            make.bottom.equalTo(titleLabel.snp.top)
        }
        
        backgroundScrollView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(secondPasswordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(backgroundView).inset(20)
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

