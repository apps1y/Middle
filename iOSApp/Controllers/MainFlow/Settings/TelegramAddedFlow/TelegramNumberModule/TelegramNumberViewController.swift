//
//  TelegramNumberViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 14.08.2024
//

import UIKit
import AppUI

// MARK: - View Protocol
protocol TelegramNumberViewProtocol: AnyObject {
    func startLoading()
    
    func finishLoading()
}

// MARK: - View Controller
final class TelegramNumberViewController: UXViewController {
    
    private lazy var phoneImageLabel: UILabel = {
        let label = UILabel()
        label.text = "☎️"
        label.font = .systemFont(ofSize: 80)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Телефон"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Проверьте код страны и введите свой номер телефона."
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var topDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    private lazy var phoneCountryField: UITextField = {
        let field = UITextField()
        field.textAlignment = .center
        field.font = .systemFont(ofSize: 20, weight: .medium)
        field.text = "+7"
        field.delegate = self
        field.keyboardType = .numberPad
        return field
    }()
    
    private lazy var verticalDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()
    
    private lazy var phoneBodyField: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 20, weight: .medium)
        field.placeholder = "000 000 0000"
        field.keyboardType = .numberPad
        field.delegate = self
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
    
    var presenter: TelegramNumberPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    deinit {
        print("vc deinit")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        phoneBodyField.becomeFirstResponder()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(dismissScreen))
        
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
        
        contentView.addSubview(phoneImageLabel)
        phoneImageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(phoneImageLabel.snp.bottom).offset(18)
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        contentView.addSubview(topDividerLine)
        topDividerLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
        }
        
        contentView.addSubview(phoneCountryField)
        phoneCountryField.snp.makeConstraints { make in
            make.leading.equalTo(contentView)
            make.top.equalTo(topDividerLine.snp.bottom).offset(5)
            make.width.equalTo(55)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(verticalDividerLine)
        verticalDividerLine.snp.makeConstraints { make in
            make.leading.equalTo(phoneCountryField.snp.trailing).offset(7)
            make.top.equalTo(topDividerLine.snp.bottom).offset(5)
            make.width.equalTo(1)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(phoneBodyField)
        phoneBodyField.snp.makeConstraints { make in
            make.leading.equalTo(verticalDividerLine).offset(17)
            make.trailing.equalTo(contentView)
            make.top.equalTo(topDividerLine.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
        
        contentView.addSubview(bottomDividerLine)
        bottomDividerLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(phoneBodyField.snp.bottom).offset(5)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    
    // MARK: - objc funcs
    @objc private func continueButtonTapped() {
        guard let phoneCountry = phoneCountryField.text, let phoneBody = phoneBodyField.text else { return }
        presenter?.enter(phoneCountry: phoneCountry, phoneBody: phoneBody)
    }
    
    @objc private func dismissScreen() {
        navigationController?.dismiss(animated: true)
    }
    
    // MARK: - privates func
    /// форматирование под маску ввод
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex

        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)

            } else {
                result.append(ch)
            }
        }
        return result
    }
    
}

// MARK: - View Protocol Realization
extension TelegramNumberViewController: TelegramNumberViewProtocol {
    func startLoading() {
        continueButton.isLoading = true
    }
    
    func finishLoading() {
        continueButton.isLoading = false
        contentView.isUserInteractionEnabled = true
    }
}


extension TelegramNumberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if textField == phoneBodyField {
            let newString = (text as NSString).replacingCharacters(in: range, with: string)
            textField.text = format(with: "XXX XXX XXXX", phone: newString)
            return false
        } else {
            if let swiftRange = Range(range, in: text) {
                let substringToDelete = text[swiftRange]
                if substringToDelete.contains("+") { return false }
            }
            if text.count + string.count > 5 { return false }
            
            return true
        }
    }
}
