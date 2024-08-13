//
//  File.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 21.07.2024.
//

import UIKit
import SnapKit

protocol UIVerifyTextFieldDelegate: AnyObject {
    func activeNextField(tag: Int)
    
    func activePreviosField(tag: Int)
}


final class UIVerifyTextField: UITextField {
    
    weak var fieldDelegate: UIVerifyTextFieldDelegate?
    
    private let style: CodeFieldStyle
    
    init(style: CodeFieldStyle) {
        self.style = style
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 14
        layer.cornerCurve = .continuous
        tintColor = .clear
        textColor = .label
        textAlignment = .center
        delegate = self
        keyboardType = .numberPad
        textContentType = .oneTimeCode
        autocapitalizationType = .none
        
        switch style {
        case .system:
            layer.borderColor = UIColor.systemBlue.cgColor
            backgroundColor = .secondarySystemBackground
            layer.borderWidth = 0
            font = .systemFont(ofSize: 26, weight: .medium)
        case .telegram:
            layer.borderColor = UIColor.separator.cgColor
            layer.borderWidth = 1.5
            font = UIFont(name: "Menlo-Regular", size: 25)
        }
    }
    
    
    override func deleteBackward() {
        fieldDelegate?.activePreviosField(tag: tag)
    }
}

extension UIVerifyTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        text = string
        
        if range.length == 0 {
            fieldDelegate?.activeNextField(tag: tag)
            resignFirstResponder()
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) {
            switch self.style {
            case .system:
                self.layer.borderWidth = 2
            case .telegram:
                self.layer.borderColor = UIColor.systemBlue.cgColor
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1) {
            switch self.style {
            case .system:
                self.layer.borderWidth = 0
            case .telegram:
                self.layer.borderColor = UIColor.separator.cgColor
            }
        }
    }
}


