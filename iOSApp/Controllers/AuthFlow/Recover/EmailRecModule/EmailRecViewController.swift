//
//  EmailRecViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit
import AppUI
import SnapKit

// MARK: - View Protocol
protocol EmailRecViewProtocol: AnyObject {
    func startLoading()
    
    func finishLoading(with error: String?)
}

// MARK: - View Controller
final class EmailRecViewController: UXViewController {
    
    // MARK: - UI
    
    private lazy var contentView = UIView()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите почту"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "На нее придет код для сброса пароля."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField: TextField = {
        let field = TextField()
        field.placeholder = "Почта"
        field.keyboardType = .emailAddress
        field.autocapitalizationType = .none
        field.textContentType = .none
        field.delegate = self
        field.returnKeyType = .done
        field.text = email
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
    
    private let email: String?
    var presenter: EmailRecPresenterProtocol?
    
    init(email: String?) {
        self.email = email
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
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
            make.height.equalTo(50)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    // MARK: - @objc funcs
    
    @objc private func continueButtonTapped() {
        guard let text = emailTextField.text else { return }
        presenter?.register(with: text)
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - View Protocol Realization
extension EmailRecViewController: EmailRecViewProtocol {
    func startLoading() {
        continueButton.isLoading = true
        emailTextField.mode = .basic
        view.endEditing(true)
        emailTextField.isEnabled = false
        navigationItem.leftBarButtonItem?.isEnabled = false
        errorLabel.hideWarning()
    }
    
    func finishLoading(with error: String?) {
        continueButton.isLoading = false
        emailTextField.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        
        guard let error else { return }
        errorLabel.showWarning(message: error)
        emailTextField.mode = .error
    }
}

extension EmailRecViewController: UITextFieldDelegate {
    
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

