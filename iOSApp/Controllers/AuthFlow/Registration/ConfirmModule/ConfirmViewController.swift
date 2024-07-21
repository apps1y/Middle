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
final class ConfirmViewController: UIViewController {
    
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
        label.text = "Введите код"
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var codeField: CodeField = {
        let field = CodeField(countOfFields: 4)
        field.verifyDelegate = self
        return field
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
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
        
        backgroundScrollView.addSubview(codeField)
        codeField.snp.makeConstraints { make in
            make.centerY.equalTo(backgroundView.snp.centerY)
            make.centerX.equalTo(backgroundView)
            make.height.equalTo(60)
            make.width.equalTo(210)
        }
        
        backgroundScrollView.addSubview(pageNameLabel)
        pageNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(codeField.snp.top)
            make.top.equalTo(backgroundView)
        }
        
        backgroundScrollView.addSubview(spinnerView)
        spinnerView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(backgroundView).inset(15)
            make.bottom.equalTo(backgroundView).inset(20)
            make.height.equalTo(50)
        }
        
        
    }
    
    private func finishEnterCode() {
        
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
    }
    
    func finishLoading(error: String?) {
        codeField.isEnable = true
        spinnerView.stopAnimating()
        
        guard let error else { return }
        codeField.clearFields()
        codeField.startAgain()
    }
}

extension ConfirmViewController: CodeFieldDelegate {
    func didFillAllFields(code: String) {
        presenter?.confirm(mail: "", with: "")
    }
}
