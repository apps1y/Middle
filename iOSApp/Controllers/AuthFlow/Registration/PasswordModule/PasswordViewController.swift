//
//  PasswordViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

// MARK: - View Protocol
protocol PasswordViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class PasswordViewController: UIViewController {
    
    var presenter: PasswordPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoaded()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - View Protocol Realization
extension PasswordViewController: PasswordViewProtocol {
    
}
