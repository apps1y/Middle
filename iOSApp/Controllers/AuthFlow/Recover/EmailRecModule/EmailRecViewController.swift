//
//  EmailRecViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

// MARK: - View Protocol
protocol EmailRecViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class EmailRecViewController: UIViewController {
    
    var presenter: EmailRecPresenterProtocol?

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
extension EmailRecViewController: EmailRecViewProtocol {
    
}
