//
//  Button.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 20.07.2024.
//

import UIKit

public final class Button: UIButton {
    
    public var isLoading: Bool = false {
        didSet {
            if isLoading {
                startLoading()
            } else {
                finishLoading()
            }
        }
    }
    
    private lazy var spinner: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .white
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 13
        layer.cornerCurve = .continuous
        backgroundColor = .systemBlue
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    
    private func startLoading() {
        isEnabled = false
        UIView.animate(withDuration: 0.1) {
            self.titleLabel?.alpha = 0
        } completion: { done in
            self.spinner.startAnimating()
        }
    }
    
    private func finishLoading() {
        isEnabled = true
        spinner.stopAnimating()
        UIView.animate(withDuration: 0.1) {
            self.titleLabel?.alpha = 1
        }
    }
}
