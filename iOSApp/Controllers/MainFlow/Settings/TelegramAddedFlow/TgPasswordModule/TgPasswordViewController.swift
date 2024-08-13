//
//  TgPasswordViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import AppUI

// MARK: - View Protocol
protocol TgPasswordViewProtocol: AnyObject {
    func startLoading()
    
    func finishLoading()
}

// MARK: - View Controller
final class TgPasswordViewController: UXViewController {
    
    private lazy var monkeyImageLabel: UILabel = {
        let label = UILabel()
        label.text = "🙈"
        label.font = .systemFont(ofSize: 80)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ваш пароль"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Вы включили двухэтапную аутентификацию. Теперь Ваш аккаунт защищён дополнительным облачным паролем."
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Пароль"
        field.font = .systemFont(ofSize: 17, weight: .medium)
        field.textContentType = .none
        field.keyboardType = .asciiCapable
        field.isSecureTextEntry = true
        return field
    }()
    
    private lazy var bottomDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    private lazy var continueButton: Button = {
        let button = Button()
        button.setTitle("Продолжить", for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentView = UIView()
    
    var presenter: TgPasswordPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewDidAppear(_ animated: Bool) {
        passwordTextField.becomeFirstResponder()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(backButtonTapped))
        
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-15)
            make.height.equalTo(47)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.centerY.lessThanOrEqualTo(view.snp.centerY)
            make.bottom.lessThanOrEqualTo(continueButton.snp.top).offset(-35)
        }
        
        contentView.addSubview(monkeyImageLabel)
        monkeyImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(monkeyImageLabel.snp.bottom).offset(18)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        contentView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(55)
            make.leading.trailing.equalToSuperview().inset(15)
            make.height.equalTo(35)
        }
        
        contentView.addSubview(bottomDividerLine)
        bottomDividerLine.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.9)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc funcs
    @objc private func backButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func continueButtonTapped() {
        guard let password = passwordTextField.text else { return }
        presenter?.enter(password: password)
    }
}

// MARK: - View Protocol Realization
extension TgPasswordViewController: TgPasswordViewProtocol {
    func startLoading() {
        continueButton.isLoading = true
    }
    
    func finishLoading() {
        continueButton.isLoading = false
    }
}
