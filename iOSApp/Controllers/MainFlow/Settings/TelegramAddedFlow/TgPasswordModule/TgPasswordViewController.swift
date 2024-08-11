//
//  TgPasswordViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit

// MARK: - View Protocol
protocol TgPasswordViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class TgPasswordViewController: UIViewController {
    
    var presenter: TgPasswordPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - View Protocol Realization
extension TgPasswordViewController: TgPasswordViewProtocol {
    
}
