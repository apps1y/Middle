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
final class EmailRecViewController: UIViewController {
    
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
        label.text = "Введите почту"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "На нее придет код для сброса пароля."
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var titleView = UIView()
    
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
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if email == nil {
            emailTextField.becomeFirstResponder()
        }
    }
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(
                -(navigationController?.navigationBar.frame.size.height ?? 25)
            )
        }
        if #available(iOS 15.0, *) {
            backgroundView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
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
            make.centerY.equalTo(backgroundView.snp.centerY)
            make.height.equalTo(50)
        }
        
        backgroundScrollView.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(backgroundView).inset(20)
            make.height.equalTo(50)
        }
        
        backgroundScrollView.addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(emailTextField.snp.top)
            make.height.equalTo(70)
        }
        
        backgroundScrollView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(titleView.snp.centerY).offset(-5)
        }
        
        backgroundScrollView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.top.equalTo(titleView.snp.centerY).offset(5)
        }
        
        backgroundScrollView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(backgroundView)
            make.centerX.equalTo(backgroundView)
            make.width.equalTo(200)
            make.bottom.equalTo(titleView.snp.top)
        }
        
        backgroundScrollView.addSubview(errorLabel)
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(backgroundView).inset(20)
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

