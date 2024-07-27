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
    
    private lazy var pageNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Восстановление"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var emailTextField: TextField = {
        let field = TextField()
        field.placeholder = "Введите почту"
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
            make.centerY.equalTo(backgroundView.snp.centerY)
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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    // MARK: - @objc funcs
    
    @objc private func continueButtonTapped() {
        guard let text = emailTextField.text else { return }
        presenter?.register(with: text)
    }
    
    @objc private func cancelButtonTapped() {
        view.endEditing(true)
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
    }
    
    func finishLoading(with error: String?) {
        continueButton.isLoading = false
        emailTextField.isEnabled = true
        navigationItem.leftBarButtonItem?.isEnabled = true
        
        guard let text = error else { return }
        // errorLabel.text = text
        emailTextField.mode = .error
    }
}

extension EmailRecViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if emailTextField.mode == .error {
            emailTextField.mode = .basic
        }
        
        if string.count > 1 || string == " " {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        continueButtonTapped()
        return true
    }
}

