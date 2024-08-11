//
//  TgNumberViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit
import AppUI

// MARK: - View Protocol
protocol TgNumberViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class TgNumberViewController: UXViewController {
    
    var presenter: TgNumberPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(dismissScreen))
        
        
    }
    
    @objc private func dismissScreen() {
        self.navigationController?.dismiss(animated: true)
    }
}

// MARK: - View Protocol Realization
extension TgNumberViewController: TgNumberViewProtocol {
    
}
