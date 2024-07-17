//
//  MessageViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 17.07.2024
//

import UIKit

// MARK: - View Protocol
protocol MessageViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class MessageViewController: UIViewController {
    
    var presenter: MessagePresenterProtocol?

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
extension MessageViewController: MessageViewProtocol {
    
}
