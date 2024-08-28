//
//  RepasswordPreviewViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.08.2024
//

import UIKit
import AppUI
import SnapKit

// MARK: - View Protocol
protocol RepasswordPreviewViewProtocol: AnyObject {
    /// начало анимации загрузки
    func startLoading()
    
    /// конец загрузки 
    func finishLoading()
}

// MARK: - View Controller
final class RepasswordPreviewViewController: UIViewController {
    
    private lazy var imageLabel: UILabel = {
        let label = UILabel()
        label.text = "🔐"
        label.font = .systemFont(ofSize: 80)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Смена пароля"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "После смены пароля потребуется повторный вход в аккаунт на других устройствах."
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var continueButton: Button = {
        let button = Button()
        button.setTitle("Изменить пароль", for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentView = UIView()
    
    var presenter: RepasswordPreviewPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(imageLabel)
        imageLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.height.equalTo(47)
        }
    }
    
    // MARK: - objc funcs
    @objc private func continueButtonTapped() {
        presenter?.prepareAccountConfirmation()
    }
}

// MARK: - View Protocol Realization
extension RepasswordPreviewViewController: RepasswordPreviewViewProtocol {
    func startLoading() {
        continueButton.isLoading = true
    }
    
    func finishLoading() {
        continueButton.isLoading = false
    }
    
    
}
