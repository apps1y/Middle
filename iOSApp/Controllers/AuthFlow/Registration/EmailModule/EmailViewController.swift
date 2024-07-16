//
//  EmailViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 16.07.2024
//

import UIKit

// MARK: - View Protocol
protocol EmailViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class EmailViewController: UIViewController {
    
    var presenter: EmailPresenterProtocol?

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
extension EmailViewController: EmailViewProtocol {
    
}
