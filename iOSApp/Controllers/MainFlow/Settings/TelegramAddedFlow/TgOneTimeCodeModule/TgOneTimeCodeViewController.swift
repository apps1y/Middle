//
//  TgOneTimeCodeViewController.swift
//  Super easy dev
//
//  Created by vanyaluk on 09.08.2024
//

import UIKit

// MARK: - View Protocol
protocol TgOneTimeCodeViewProtocol: AnyObject {
    
}

// MARK: - View Controller
final class TgOneTimeCodeViewController: UIViewController {
    
    var presenter: TgOneTimeCodePresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}

// MARK: - View Protocol Realization
extension TgOneTimeCodeViewController: TgOneTimeCodeViewProtocol {
    
}
