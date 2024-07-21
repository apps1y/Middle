//
//  TextField.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 20.07.2024.
//

import UIKit

public enum TextFeildMode {
    case basic
    case error
}

public final class TextField: UITextField {
    
    public var mode: TextFeildMode = .basic {
        didSet {
            if mode == .basic {
                setBasicMode()
            } else {
                setErrorMode()
            }
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setupUI()
        setBasicMode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        leftViewMode = .always
        layer.cornerRadius = 13
        layer.cornerCurve = .continuous
        layer.borderColor = UIColor.systemRed.cgColor
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        autocorrectionType = .no
        rightViewMode = .always
    }
    
    /// Делает обычный цвет для TextField
    private func setBasicMode() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = .secondarySystemBackground
            self.layer.borderWidth = 0
        }
    }
    
    /// Делает TextField красным, режим ошибки
    private func setErrorMode() {
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = .systemRed.withAlphaComponent(0.2)
            self.layer.borderWidth = 1
        }
    }
    
    @objc private func togglePasswordView(_ sender: UIButton) {
            sender.isSelected.toggle()
            isSecureTextEntry.toggle()
        }
    
    // MARK: - Publics funcs
    
    /// настройка значка показа пароля
    public func addShowButton() {
        let passwordToggleButton = UIButton(type: .custom)
        passwordToggleButton.setImage(UIImage(systemName: "eye"), for: .selected)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        passwordToggleButton.tintColor = .lightGray
        
        // Создаем контейнер с отступами для кнопки
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        passwordToggleButton.frame = CGRect(x: 0, y: 5, width: 35, height: 30)
        paddingView.addSubview(passwordToggleButton)
        
        rightView = paddingView
    }
    
    
}
