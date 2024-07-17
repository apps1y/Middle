//
//  PasswordRecViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

// MARK: - View Protocol
protocol PasswordRecViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class PasswordRecViewController: UIViewController {
    
    var presenter: PasswordRecPresenterProtocol?

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
extension PasswordRecViewController: PasswordRecViewProtocol {
    
}
