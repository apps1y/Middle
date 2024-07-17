//
//  NewMessageViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

// MARK: - View Protocol
protocol NewMessageViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class NewMessageViewController: UIViewController {
    
    var presenter: NewMessagePresenterProtocol?

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
extension NewMessageViewController: NewMessageViewProtocol {
    
}
