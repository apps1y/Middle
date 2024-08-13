//
//  CodeField1.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 06.08.2024.
//

import UIKit
import SnapKit


public protocol CodeFieldDelegate: AnyObject {
    
    /// функция, возвращающая значение, когда все поля введены
    func didFillAllFields(code: String)
}

public enum CodeFieldStyle {
    case system
    case telegram
}

public final class CodeField: UIView {
    
    public weak var verifyDelegate: CodeFieldDelegate?
    
    var fieldStack = UIStackView()
    var verifyTextFields = [UIVerifyTextField]()
    
    /// отключает/включает  взаимодействие с полем
    public var isEnable: Bool = true {
        didSet {
            verifyTextFields.forEach { field in
                field.isEnabled = isEnable
            }
        }
    }
    
    private let countOfFields: Int
    private let spacing: CGFloat
    
    private let style: CodeFieldStyle
    
    public init(countOfFields: Int, spacing: CGFloat = 5, style: CodeFieldStyle = .system) {
        self.countOfFields = countOfFields
        self.spacing = spacing
        self.style = style
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        fieldStack.spacing = spacing
        fieldStack.distribution = .fillEqually
        
        for number in 0..<countOfFields {
            let field = UIVerifyTextField(style: style)
            field.tag = number
            field.fieldDelegate = self
            verifyTextFields.append(field)
            fieldStack.addArrangedSubview(field)
        }
        
        addSubview(fieldStack)
        fieldStack.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
    }
    
    private func getFieldsCode() -> String {
        var code = ""
        verifyTextFields.forEach {
            code.append($0.text ?? "")
        }
        return code
    }
    
    public func clearFields() {
        verifyTextFields.forEach { field in
            field.text = ""
        }
    }
    
    public func startAgain() {
        verifyTextFields[0].becomeFirstResponder()
    }
}

extension CodeField: UIVerifyTextFieldDelegate {
    func activeNextField(tag: Int) {
        if tag != verifyTextFields.count - 1 {
            verifyTextFields[tag + 1].becomeFirstResponder()
        } else {
            verifyDelegate?.didFillAllFields(code: getFieldsCode())
        }
    }
    
    func activePreviosField(tag: Int) {
        if tag != 0 {
            verifyTextFields[tag - 1].text = ""
            verifyTextFields[tag - 1].becomeFirstResponder()
        }
    }
}
