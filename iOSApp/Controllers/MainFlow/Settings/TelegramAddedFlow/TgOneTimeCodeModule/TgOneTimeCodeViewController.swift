//
//  TgOneTimeCodeViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import AppUI

// MARK: - View Protocol
protocol TgOneTimeCodeViewProtocol: AnyObject {
    func startLoading()
    
    func finishLoading(startAgain: Bool)
}

// MARK: - View Controller
final class TgOneTimeCodeViewController: UXViewController {
    
    private lazy var bubbleImageLabel: UILabel = {
        let label = UILabel()
        label.text = "💬"
        label.font = .systemFont(ofSize: 80)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите код"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправили код через Telegram на другое устройство, где авторизован \(number)."
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var codeField: CodeField = {
        let field = CodeField(countOfFields: 5, spacing: 12, style: .telegram)
        field.verifyDelegate = self
        return field
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        return view
    }()
    
    private lazy var contentView = UIView()
    
    var presenter: TgOneTimeCodePresenterProtocol?
    private let number: String
    
    init(number: String) {
        self.number = number
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
        codeField.startAgain()
        
        view.backgroundColor = .systemBackground
        scrollView.isScrollEnabled = false
        
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(backButtonTapped))
        
        scrollView.addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-15)
            make.height.equalTo(47)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(20)
            make.centerY.lessThanOrEqualTo(view.snp.centerY)
            make.bottom.lessThanOrEqualTo(spinner.snp.top).offset(-20)
        }
        
        contentView.addSubview(bubbleImageLabel)
        bubbleImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bubbleImageLabel.snp.bottom).offset(18)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        contentView.addSubview(codeField)
        codeField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(260)
            make.height.equalTo(50)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(35)
            make.bottom.equalToSuperview()
        }
    }
    
    
    
    // MARK: - @objc funcs
    @objc private func backButtonTapped() {
        navigationController?.dismiss(animated: true)
    }
}

// MARK: - View Protocol Realization
extension TgOneTimeCodeViewController: TgOneTimeCodeViewProtocol {
    func startLoading() {
        spinner.startAnimating()
    }
    
    func finishLoading(startAgain: Bool) {
        spinner.stopAnimating()
        if startAgain {
            codeField.clearFields()
            codeField.startAgain()
        }
    }
}

extension TgOneTimeCodeViewController: CodeFieldDelegate {
    func didFillAllFields(code: String) {
        presenter?.enter(code: code)
    }
}
