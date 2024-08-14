//
//  UXViewController.swift
//  AppUI
//
//  Created by Иван Лукъянычев on 11.08.2024.
//

import UIKit


/// от него нужно наследовать контроллеры, в которых нужно поднятие клавиатуры
/// в основе лежит scrollView, на который нужно добавлять элементы
/// от этого класса нужно наследоваться
open class UXViewController: UIViewController {
    public lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.keyboardDismissMode = .interactiveWithAccessory
        view.alwaysBounceVertical = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// view behind scrollView
    public lazy var background = UIView()
    
    private lazy var keyboardTopAnchor: NSLayoutConstraint = {
        keyboardLayoutGuide.topAnchor.constraint(equalTo: view.bottomAnchor,
                                            constant: view.safeAreaInsets.bottom)
    }()
    
    public let keyboardLayoutGuide: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private var isListeningKeypadChange = false
    
    private lazy var maxKeyboardHeight: CGFloat = {
        -1.0
    }()
    
    private var safeAreaBottomInsets: CGFloat = 34.0
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        setupObservers()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        scrollView.panGestureRecognizer.removeTarget(self, action: nil)
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(keyboardLayoutGuide)
        NSLayoutConstraint.activate([
            keyboardLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            keyboardLayoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardLayoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardTopAnchor
        ])
        
        view.addSubview(background)
        background.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if maxKeyboardHeight == -1.0 {
            maxKeyboardHeight = view.safeAreaInsets.bottom
            keyboardTopAnchor.constant = -view.safeAreaInsets.bottom
        }
    }
    
    // MARK: - observers
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Any],
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt,
              let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        if !isListeningKeypadChange {
            maxKeyboardHeight = value.cgRectValue.height
            keyboardTopAnchor.constant = -value.cgRectValue.height

            let options = UIView.AnimationOptions.beginFromCurrentState.union(UIView.AnimationOptions(rawValue: animationCurve))
            UIView.animate(withDuration: animationDuration, delay: 0, options: options, animations: { [weak self] in
                self?.view.layoutIfNeeded()
                }, completion: { [weak self] done in
                    guard done else { return }
                    self?.beginListeningKeyboardChange()
            })
        }
        else {
            isListeningKeypadChange = false
            keyboardTopAnchor.constant = -value.cgRectValue.height
        }
    }
    
    @objc private func keyboardWillChange(_ notification: Notification) {
        if isListeningKeypadChange, let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            maxKeyboardHeight = value.cgRectValue.height
            keyboardTopAnchor.constant = -value.cgRectValue.height
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo as? [String : Any] else { return }
        
        maxKeyboardHeight = view.safeAreaInsets.bottom
        keyboardTopAnchor.constant = -view.safeAreaInsets.bottom
        
        var options = UIView.AnimationOptions.beginFromCurrentState
        if let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            options = options.union(UIView.AnimationOptions(rawValue: animationCurve))
        }

        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
        UIView.animate(withDuration: duration ?? 0, delay: 0, options: options) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardDidHide() {
        isListeningKeypadChange = false
        scrollView.panGestureRecognizer.removeTarget(self, action: nil)
        let bottom = view.safeAreaInsets.bottom
        if maxKeyboardHeight != bottom || keyboardTopAnchor.constant != bottom {
            maxKeyboardHeight = view.safeAreaInsets.bottom
            keyboardTopAnchor.constant = -view.safeAreaInsets.bottom
        }
    }
    
    
    // MARK: - UIPanGestureRecognizer
    @objc private func handlePanGestureRecognizer(_ pan: UIPanGestureRecognizer) {
        guard isListeningKeypadChange else {
            isListeningKeypadChange = true
            
            let dragY = view.frame.height - pan.location(in: view).y
            let duration = (1 - dragY / 336) * 0.25
            let safeDuration = max(duration, 0)
            UIView.animate(withDuration: safeDuration, delay: 0, animations: {
                self.view.layoutIfNeeded()
            })
            
            return
        }
        
        let windowHeight = view.frame.height
        let keyboardHeight = abs(keyboardTopAnchor.constant)
        
        let dragY = windowHeight - pan.location(in: view).y
        let newValue = min(dragY < keyboardHeight ? max(dragY, view.safeAreaInsets.bottom) : dragY, maxKeyboardHeight)
        
        guard keyboardHeight != newValue else { return }
        keyboardTopAnchor.constant = -newValue
    }
    
    private func beginListeningKeyboardChange() {
        isListeningKeypadChange = true
        scrollView.panGestureRecognizer.addTarget(self, action: #selector(handlePanGestureRecognizer(_:)))
    }
}


