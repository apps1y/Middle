//
//  ConfirmViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit
import AppUI
import SnapKit

// MARK: - View Protocol
protocol ConfirmViewProtocol: AnyObject {
    
    /// начало анимации загрузки EmailViewController
    func startLoading()
    
    /// завершение анимации загрузки с возможной ошибкой
    /// - Parameters:
    ///   - error: текст ошибки для пользователя (если false, то ошибки нет)
    func finishLoading(error: String?)
}

// MARK: - View Controller
final class ConfirmViewController: UXViewController {
    
    // MARK: - UI
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправлили код Вам на почту. Он мог попасть в спам."
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var codeField: CodeField = {
        let field = CodeField(countOfFields: 4, spacing: 7)
        field.verifyDelegate = self
        return field
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "onboardingLogo")
        return view
    }()
    
    var presenter: ConfirmPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        codeField.startAgain()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(backButtonTapped))
        
        scrollView.addSubview(spinnerView)
        spinnerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(15)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top)
            make.height.equalTo(45)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(15)
            make.centerY.lessThanOrEqualTo(view.snp.centerY).offset(-50)
            make.bottom.lessThanOrEqualTo(spinnerView.snp.top).offset(-30)
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
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(7)
        }
        
        contentView.addSubview(codeField)
        codeField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.width.equalTo(186)
            make.centerX.bottom.equalToSuperview()
        }
    }
    
    // MARK: - @objc func
    
    @objc private func backButtonTapped() {
        /// на предыдущий экран
        view.endEditing(true)
        navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - View Protocol Realization
extension ConfirmViewController: ConfirmViewProtocol {
    func startLoading() {
        spinnerView.startAnimating()
        codeField.isEnable = false
        navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    func finishLoading(error: String?) {
        codeField.isEnable = true
        spinnerView.stopAnimating()
        navigationItem.leftBarButtonItem?.isEnabled = true
        
        // guard let error else { return }
        codeField.clearFields()
        codeField.startAgain()
    }
}

extension ConfirmViewController: CodeFieldDelegate {
    func didFillAllFields(code: String) {
        presenter?.confirm(with: code)
    }
}
