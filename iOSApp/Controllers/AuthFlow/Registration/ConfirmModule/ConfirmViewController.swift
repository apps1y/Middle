//
//  ConfirmViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 21.07.2024
//

import UIKit

// MARK: - View Protocol
protocol ConfirmViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class ConfirmViewController: UIViewController {
    
    var presenter: ConfirmPresenterProtocol?

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
extension ConfirmViewController: ConfirmViewProtocol {
    
}
