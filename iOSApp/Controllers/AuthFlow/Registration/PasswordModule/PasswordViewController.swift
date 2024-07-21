//
//  PasswordViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit
import SnapKit
import AppUI

enum PasswordFieldChoise {
    case first
    case second
}

// MARK: - View Protocol
protocol PasswordViewProtocol: AnyObject {
    
    /// начало анимации загрузки LoginViewController
    func startLoading()
    
    /// завершение анимации загрузки с возможной ошибкой
    /// - Parameters:
    ///   - error: какое поле загорится красным, текст ошибки для пользователя
    func finishLoading(with error: (PasswordFieldChoise, String)?)
}

// MARK: - View Controller
final class PasswordViewController: UIViewController {
    
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
        label.text = "Придумайте пароль"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var firstPasswordTextField: TextField = {
        let field = TextField()
        field.placeholder = "Пароль"
        field.isSecureTextEntry = true
        field.textContentType = .none
        field.delegate = self
        field.returnKeyType = .done
        field.addShowButton()
        return field
    }()
    
    private lazy var secondPasswordTextField: TextField = {
        let field = TextField()
        field.placeholder = "Повторите пароль"
        field.isSecureTextEntry = true
        field.textContentType = .none
        field.delegate = self
        field.returnKeyType = .done
        field.addShowButton()
        return field
    }()
    
    private lazy var continueButton: Button = {
        let button = Button()
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var presenter: PasswordPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        firstPasswordTextField.becomeFirstResponder()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(backButtonTapped))
        
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
        
        backgroundScrollView.addSubview(pageNameLabel)
        pageNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(firstPasswordTextField.snp.top)
            make.top.equalTo(backgroundView)
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
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - View Protocol Realization
extension PasswordViewController: PasswordViewProtocol {
    func startLoading() {
        view.endEditing(true)
        continueButton.isLoading = true
        firstPasswordTextField.isEnabled = false
        secondPasswordTextField.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    func finishLoading(with error: (PasswordFieldChoise, String)?) {
        continueButton.isLoading = false
        firstPasswordTextField.isEnabled = true
        secondPasswordTextField.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        
        guard let (field, text) = error else { return }
        // errorLabel.text = text
        switch field {
        case .first:
            firstPasswordTextField.mode = .error
            firstPasswordTextField.becomeFirstResponder()
        case .second:
            secondPasswordTextField.mode = .error
            secondPasswordTextField.becomeFirstResponder()
        }
    }
}


extension PasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstPasswordTextField {
            secondPasswordTextField.becomeFirstResponder()
        }  else if textField == secondPasswordTextField {
            continueButtonTapped()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == firstPasswordTextField && firstPasswordTextField.mode == .error {
            firstPasswordTextField.mode = .basic
        }
        if textField == secondPasswordTextField && secondPasswordTextField.mode == .error {
            secondPasswordTextField.mode = .basic
        }
        return true
    }
}
