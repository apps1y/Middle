//
//  ErrorLabel.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 27.07.2024.
//

import UIKit

public final class ErrorLabel: UILabel {
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textColor = .systemRed
        font = .systemFont(ofSize: 14, weight: .medium)
        textAlignment = .left
        numberOfLines = 2
        alpha = 0
    }
    
    public func showWarning(message: String) {
        text = message
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
    public func hideWarning() {
        if alpha == 1 {
            UIView.animate(withDuration: 0.2) { self.alpha = 0 }
        }
    }
}
