//
//  AppCoordinator.swift
//  iOSApp
//
//  Created by Иван Лукъянычев on 15.07.2024.
//

import UIKit


public protocol FlowCoordinator: AnyObject {
    func start()
}


final class AppCoordinator: FlowCoordinator {
    
    private weak var window: UIWindow?
    
    private let loginAssembly: LoginAssembly
    
    init(window: UIWindow?, loginAssembly: LoginAssembly) {
        self.loginAssembly = loginAssembly
        self.window = window
    }
    
    func start() {
        window?.rootViewController = loginAssembly.assemble()
    }
}
